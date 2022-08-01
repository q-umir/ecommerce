class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    include Pundit::Authorization


    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      # For additional fields in app/views/devise/registrations/new.html.erb
      devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])

      # For additional in app/views/devise/registrations/edit.html.erb
      devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    # after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index

    private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      # redirect_to(request.referrer || root_path)
      redirect_to root_path
    end
end
