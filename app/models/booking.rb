class Booking < ApplicationRecord

    belongs_to :workshop
    belongs_to :user
    
    validates :workshop_id, uniqueness: { scope: :user_id, message: "You have already booked your spot for this workshop"}

end
