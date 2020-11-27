class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:oktaoauth]

  #Set user after omniauth_authentication
  def self.from_omniauth(auth)
    user = User.find_or_create_by(email: auth['info']['email']) do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
      user.password = SecureRandom.hex(12)
    end

    Rails.logger.info ">>>>>>>>>>>>>>#{user.errors.full_messages}" #Log user response

  end
end
