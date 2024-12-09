class Workshop < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :bookings, dependent: :destroy

    validates :name, presence: true
    validates :max_partecipants, presence: true
    validates :max_partecipants, numericality: { greater_than: 0 }
    validate :workshop_date_cannot_be_in_the_past

    def workshop_date_cannot_be_in_the_past
        if (!date.blank? and date <= Date.today)
            errors.add(:date, "must be greater than today")
        end
    end


end
