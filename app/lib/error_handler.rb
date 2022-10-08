module ErrorHandler
	extend ActiveSupport::Concern

  included do
  	rescue_from ActionController::RoutingError do |exception|
  	end
  end
  # def self.included(clazz)
  #   clazz.class_eval do
  #   	rescue_from ActionController::RoutingError do |exception|
		#     byebug
		#     render json: {"no": "not"}
		#   end
  #   end
  # end
end