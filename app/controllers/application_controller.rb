class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_current_user

  rescue_from ActiveRecord::RecordNotFound do |e|
    logger.error "Record not found"
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end


  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:state])
    devise_parameter_sanitizer.permit(:account_update, keys: [:state])
  end

end
