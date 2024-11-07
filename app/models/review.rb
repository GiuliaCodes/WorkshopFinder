class Review < ApplicationRecord
    belongs_to :workshop
    belongs_to :user

    validates :workshop_id, uniqueness: { scope: :user_id, message: "You have already created a review for this workshop"}

end
