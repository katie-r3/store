require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
ENV['RAILS_ENV'] ||= 'test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def sign_in(user)
    post user_session_path \
      "user[email]"    => user.email,
      "user[password]" => user.password
  end
end
