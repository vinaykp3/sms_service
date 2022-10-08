class Validator
	REQUIRED_PARAMETERS = %w(from to text)
	PARAMETER_SIZE = {"from"=> { min: 6, max: 16 }, "to"=> { min: 6, max: 16 }, "text"=> {min: 1, max: 120}}

	attr_accessor :params, :account, :sms_for

	def initialize(params, account, sms_for)
		@params = params
		@account = account
		@sms_for = sms_for
	end

	def validate
		parameter_missing?
		invalid_parameter?
		valid_phone_number?
	end

	def parameter_missing?
		missing_params = REQUIRED_PARAMETERS - params.keys
		message = "#{missing_params.first} is missing"
		raise Exceptions::InvalidParams.new(message) if missing_params.present?
	end

	def invalid_parameter?
		invalid_params = params.keys - REQUIRED_PARAMETERS
		message = "#{invalid_params.first} is invalid"
		raise Exceptions::InvalidParams.new(message) if invalid_params.present?
		validate_params
	end

	def validate_params
		params.each do |key, value|
			size = PARAMETER_SIZE[key]
			message = "#{key} is invalid"
			raise Exceptions::InvalidParams.new(message) if value.length < size[:min] || value.length > size[:max]
		end
	end

	def valid_phone_number?
		number = (@sms_for == "to" ? params[:to] : params[:from])
		phone_number = account.phone_numbers.find_by(number: number)
		message = "#{@sms_for} parameter not found"
		raise Exceptions::InvalidParams.new(message) if !phone_number
	end
end
