class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :authenticate_user!, except: %i[about]
  before_action :verify_turnstile!, only: :create, if: :devise_controller?

  rate_limit to: 10, within: 3.minutes, only: :create

  include Pundit::Authorization

  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  after_action :add_flash_to_turbo_stream, if: -> { request.format.turbo_stream? }
  after_action :add_flash_to_html, if: -> { request.format.html? }

  private

  def add_flash_to_turbo_stream
    return if flash.empty?

    turbo_stream_response = render_to_string(
      partial: 'layouts/flash_stream',
      formats: [:turbo_stream]
    )

    response.body += turbo_stream_response

    flash.discard
  end

  def add_flash_to_html
    return if flash.empty?

    flash_html = render_to_string(
      partial: "layouts/flash",
      formats: [:html]
    )

    response.body = response.body.sub(
      %r{<turbo-frame id="flash">.*?</turbo-frame>}m,
      %(<turbo-frame id="flash">#{flash_html}</turbo-frame>)
    )
  end

  def verify_turnstile!
    return unless Rails.env.production?

    secret_key = Rails.application.credentials.dig(:cloudflare, :turnstile, :secret)
    token = params["cf-turnstile-response"]
    uri = "https://challenges.cloudflare.com/turnstile/v0/siteverify"
    build_json_body = { "secret" => secret_key, "response" => token, "remoteip" => request.remote_ip }

    response = HTTP.headers("Content-Type" => "application/json").post(uri, json: build_json_body)

    return if JSON.parse(response.body)["success"]

    flash[:alert] = "Please confirm you're not a bot and try again"

    redirect_back(fallback_location: root_path) and return
  rescue HTTP::ConnectionError, HTTP::TimeoutError => e
    Rails.logger.error "[Turnstile] Connection error: #{e.message}"
  end
end
