class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, :only => [:current_or_guest_user]
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_current_user

  rescue_from ActiveRecord::RecordNotFound do |e|
    logger.error "Record not found"
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

  helper_method :current_or_guest_user


  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user if with_retry
  end


  private

  def logging_in
    guest_cart_ids = $redis.lrange "cart#{guest_user.id}", 0, 100 # => ["2", "1"]
    guest_cart_ids.each do |item|
      $redis.lpush "cart#{current_user.id}", item
    end
  end

  def create_guest_user
    u = User.new(:email => "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:state, :address_line1, :address_line2, :city, :zipcode, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:state, :address_line1, :address_line2, :city, :zipcode, :first_name, :last_name])
  end

end
