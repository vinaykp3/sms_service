class Base
	attr_accessor :params, :account
	def initialize(params, account)
		@params = params
		@account = account
	end

	def message(message, error)
		{
			message: message,
			error: error
		}
	end
end