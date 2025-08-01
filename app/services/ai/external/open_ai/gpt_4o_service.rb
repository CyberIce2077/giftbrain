module Ai
  module External
    module OpenAi
      class Gpt4oService < Ai::External::OpenAi::BaseService
        def call
          super
        end

        private

        def model = "gpt-4o"
      end
    end
  end
end
