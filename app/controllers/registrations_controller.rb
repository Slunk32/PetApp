class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :avatar)
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
