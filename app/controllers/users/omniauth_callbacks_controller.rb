class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?

    user.stripe_customer = Stripe::Customer.create( email: user.email )

    user.stripe_subscription = Stripe::Subscription.create(
      customer: user.stripe_customer['id'],
      items: [
        {
          plan: 'basic-plan-databall',
        },
      ],
      trial_end: (Time.now + 14.days).to_i,
    )

    user.save


    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end




end
