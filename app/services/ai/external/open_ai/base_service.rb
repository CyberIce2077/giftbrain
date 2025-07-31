module  Ai
  module External
    module OpenAi
      class BaseService < Ai::BaseService
        URL = "https://api.openai.com/v1/chat/completions".freeze

        def call
          super

          response = HTTP.headers("Content-Type" => "application/json")
                         .headers("Authorization" => "Bearer #{api_key}")
                         .post(URL, json:
                           {
                             model:,
                             messages: [
                               { role: "system", content: "You are a helpful assistant that strictly returns JSON." },
                               { role: "user", content: build_prompt }
                             ],
                             temperature: 0.7,
                             max_tokens: 300,
                             n: 1
                           }
                         )

          @data = JSON.parse(JSON.parse(response.body.to_s).dig("choices", 0, "message", "content"))

          success!
        rescue StandardError => e
          errors.add(:base, e.message)
          log_error(e)
        end

        private

        def api_key
          Rails.application.credentials.dig(:openai, :api_key)
        end
      end
    end
  end
end
