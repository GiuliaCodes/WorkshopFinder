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
                    username: data["name"],
                    email: data["email"],
                    #encrypted_password: Devise.friendly_token[0,20]
                    password: Devise.friendly_token[0,20],
                    uid: access_token[:uid], provider: access_token[:provider]       #vanno messi?
              )
            end
              user
          end
  
  acts_as_user :roles => [:user, :partecipant, :organizer, :admin]

  has_many :reviews


=begin   #ruolo M ha k bit a 1
  def set_roleM do
    self.roles_mask == self.roles_mask | (K)
    self.save
  end 
  def is_roleM? do
    self.roles_mask & (K) = K
  end
  def unset_roleM do
      self.roles_mask = self.roles_mask & (Kinvn)
      #or   	self.roles_mask = 0 ...
      self.save
    end 
=end


def is_user?
  return (self.roles_mask & 1) == 1
end

def set_user
  self.roles_mask = (self.roles_mask | 1) 
  self.save
end

def unset_user
  self.roles_mask = (self.roles_mask & 14) 
  self.save
end


def is_partecipant?
  return (self.roles_mask & 2) == 2
end

def set_partecipant
  self.roles_mask = (self.roles_mask | 2) 
  self.save
end

def unset_partecipant
  self.roles_mask = (self.roles_mask & 13) 
  self.save
end


def is_organizer?
  return (self.roles_mask & 4) == 4
end

def set_organizer
  self.roles_mask = (self.roles_mask | 4) 
  self.save
end

def unset_organizer
  self.roles_mask = (self.roles_mask & 11) 
  self.save
end


def is_admin?
  return (self.roles_mask & 8) == 8
end

def set_admin
  self.roles_mask = (self.roles_mask | 8) 
  self.save
end

def unset_admin
  self.roles_mask = (self.roles_mask & 7) 
  self.save
end

end
