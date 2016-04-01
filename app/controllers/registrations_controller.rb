class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :phone_number, :avatar, :address, :longitude, :latitude)
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
