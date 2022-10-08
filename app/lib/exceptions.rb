module Exceptions
  class Base < StandardError
    attr_reader :custom_message, :error_code

    def initialize(msg = nil)
      @custom_message = msg
      super(@custom_message)
    end
  end

  class InvalidParams < Base; end
end