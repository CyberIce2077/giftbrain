module  Ai
  module External
    module OpenAi
      class BaseService < Ai::BaseService
        URL = "https://api.openai.com/v1/chat/completions".freeze

        def call
          super

          return demo_response if Rails.env.development?

          response = open_ai_client.post do |r|
            r.body = build_params
          end

          result = response.body
          puts result

          @data = JSON.parse(result.dig("choices", 0, "message", "content"))
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
            messages: [
              { role: "system", content: "You are a helpful assistant that strictly returns JSON." },
              { role: "user", content: build_prompt }
            ],
            temperature: 0.7,
            max_tokens: 300,
            n: 1
          }
        end

        def open_ai_client
          Faraday.new(URL) do |conn|
            conn.headers['Authorization'] = "Bearer #{api_key}"
            conn.response :json
            conn.request :json
            conn.adapter Faraday.default_adapter
          end
        end

        def api_key
          Rails.application.credentials.dig(:openai, :api_key)
        end

        def demo_response
          @data = [
            { "name" => "Beer mug" },
            { "name" => "Anime Rem figurine" },
            { "name" => "Cat poster" },
            { "name" => "Re Zero anime figurine" },
            { "name" => "Makeup" }
          ]
          success!
        end
      end
    end
  end
end
