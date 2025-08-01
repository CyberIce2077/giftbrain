module Ai
  module Local
    class Phi4MiniService < Ai::Local::BaseService
      def call
        super
      end

      private

      def model = "phi4-mini:3.8b"
    end
  end
end
