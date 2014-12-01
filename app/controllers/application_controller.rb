class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_error(object_with_error)
  	if object_with_error == nil
  		flash[:error] = "LOGIN INCORRECT, PLEASE TRY AGAIN"
    else
    	flash[:error] = object_with_error.errors.full_messages
  	end
  end
end
