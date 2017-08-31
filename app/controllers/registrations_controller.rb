class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    '/odds' # Or :prefix_to_your_route
  end

   def after_inactive_sign_up_path_for(resource)
    'root_path' # Or :prefix_to_your_route
  end
end

