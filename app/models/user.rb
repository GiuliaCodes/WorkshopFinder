class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]


          def self.from_omniauth(access_token)
            data = access_token.info
            user = User.where(:email => data["email"]).first
        
            # Uncomment the section below if you want users to be created if they don't exist
            unless user
              user = User.create(
                    #name: data["name"],
                    email: data["email"],
                    #encrypted_password: Devise.friendly_token[0,20]
                    password: Devise.friendly_token[0,20],
                    uid: access_token[:uid], provider: 'google'       #vanno messi?
              )
            end
              user
          end

    
end
