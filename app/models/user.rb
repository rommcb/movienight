class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def configure_permitted_parameters
  # For additional fields in app/views/devise/registrations/new.html.erb
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

  # For additional in app/views/devise/registrations/edit.html.erb
  devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
