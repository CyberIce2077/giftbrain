module Affiliate
  class AliexpressClient
    URL = "https://api-sg.aliexpress.com/sync".freeze

    def initialize
      @connection = Faraday.new(URL) do |conn|
        conn.response :json
        conn.request :json
        conn.adapter Faraday.default_adapter
      end
    end

    def get(params)
      @connection.get do |r|
        params.each do |key, value|
          r.params[key] = value
        end

        r.params["sign_method"] = "sha256"
        r.params["app_key"] = app_key
        r.params["timestamp"] = (Time.now.to_f * 1000).to_i
        r.params["sign"] = encrypted_sign(r.params)
      end
    end

    private

    def encrypted_sign(params)
      sort_params = params.sort.to_h

      sign_params = ""

      sort_params.each do |k, v|
        sign_params += k.to_s
        sign_params += v.to_s
      end

      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), app_secret, sign_params).upcase
    end

    def app_key
      Rails.application.credentials.dig(:affiliate, :aliexpress, :app_key)
    end

    def app_secret
      Rails.application.credentials.dig(:affiliate, :aliexpress, :app_secret)
    end
  end
end
