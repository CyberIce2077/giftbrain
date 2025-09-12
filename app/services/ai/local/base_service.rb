module Ai
  module Local
    class BaseService < Ai::BaseService
      def call
        super

        response = client.post do |r|
          r.body = build_params
        end

        result = response.body

        @data = JSON.parse(result.gsub(/\A```json\s*|\s*```\z/, "")).dig("response")
        validate_data_presence!

        success!
      rescue StandardError => e
        errors.add(:base, e.message)
        log_error(e)
      end

      private

      def build_params
        {
          model:,
          prompt: build_prompt,
          stream: false
        }
      end

      def client
        Faraday.new(url) do |c|
          c.request :retry, interval: 0.05, interval_randomness: 0.5, backoff_factor: 2
          c.request :json
          c.response :json
        end
      end

      def url
        return "http://localhost:11434/api/generate" if Rails.env.development?

        "http://giftbrain-ollama:11434/api/generate"
      end
    end
  end
end
