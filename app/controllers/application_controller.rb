# require 'lib/error_handler'
class ApplicationController < ActionController::API
	include ErrorHandler
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	before_action :authenticate

	private

  	def authenticate
  		authenticate_or_request_with_http_basic do |username, password|
		    account = Account.where(username: username, auth_id: password).first
		    valid_account = (username == account&.username && password == account&.auth_id)
		    if valid_account
		    	@current_account = account
		    	true
		    else
		    	render status: 403
		    end
		  end
  	end


  	def account
  		@account ||= Account.where(username: username, auth_id: password).first
  	end

end
