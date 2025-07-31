module Ai
  module Local
    class BaseService < Ai::BaseService
      API_PATH = "api/generate".freeze

      def call
        super

        response = HTTP.headers("Content-Type" => "application/json")
                       .post(url, json: {
                         model:,
                         prompt: build_prompt,
                         stream: false
                       })

        json_string = JSON.parse(response.body.to_s)["response"]

        @data = JSON.parse(json_string.gsub(/\A```json\s*|\s*```\z/, ''))

        success!
      rescue StandardError => e
        errors.add(:base, e.message)
        log_error(e)
      end

      def url
        return "http://localhost:11434/#{API_PATH}" if Rails.env.development?

        "http://giftbrain-ollama:11434/#{API_PATH}"
      end
    end
  end
end
