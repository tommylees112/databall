class SubscribersController < ApplicationController

  def cancel_plan
    subscription = Stripe::Subscription.retrieve("sub_BM93lo0kON8IxI")
    subscription.delete(:at_period_end => true)
    current_user.update(access: false)
  end
end
