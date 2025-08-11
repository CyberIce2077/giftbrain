module ApplicationHelper
  def turnstile_widget
    return unless Rails.env.production?

    sitekey = Rails.application.credentials.dig(:cloudflare, :turnstile, :key)

    content_tag(:div, "", class: "cf-turnstile", data: { sitekey:, theme: "light" })
  end
end
