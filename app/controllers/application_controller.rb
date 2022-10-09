# require 'lib/error_handler'
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :authenticate

  rescue_from ActionController::RoutingError, :with => :render_not_found

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render status: 405
  end

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
