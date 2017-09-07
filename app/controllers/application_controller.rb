class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_action :set_access



  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end





  # def set_access
  #   if current_user.stripe_subscription['status'] == 'canceled'
  #     current_user.update(access: false)
  #   elsif (current_user.stripe_subscription['status'] == 'trialing') || (current_user.stripe_subscription['status'] == 'active')
  #     current_user.update(access: true)
  #   end
  # end
end
