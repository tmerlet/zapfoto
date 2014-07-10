class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def after_sign_in_path_for(resource)
    if current_user.current_roll
      session["user_return_to"] || roll_path(current_user.current_roll)
    else
      session["user_return_to"] || new_roll_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
