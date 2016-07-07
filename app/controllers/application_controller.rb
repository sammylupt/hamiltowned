class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :http_authentication

  def http_authentication
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == 'password'
    end
  end
end
 