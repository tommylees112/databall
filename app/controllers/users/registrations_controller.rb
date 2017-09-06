class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    resource.stripe_customer = Stripe::Customer.create( email: resource.email )

    resource.stripe_subscription = Stripe::Subscription.create(
      customer: resource.stripe_customer['id'],
      items: [
        {
          plan: 'basic-plan-databall',
        },
      ],
      trial_end: (Time.now + 30.days).to_i,
    )

    resource.save

    flash[:notice] = "Your trial will end in 30 days"
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def after_sign_up_path_for(resource)
    '/odds' # Or :prefix_to_your_route
  end

   def after_inactive_sign_up_path_for(resource)
    root_path # Or :prefix_to_your_route
  end
end
