require 'rails_helper'

RSpec.describe Booking, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  fixtures :all
  context "validations" do
    it "is valid if unique" do
      workshop=workshops(:one)
      user=users(:user)
      booking=Booking.new( :workshop_id => workshop.id, :user_id => user.id)
      expect(booking).to be_valid
    end
    it "requires that each user can book a workshop once" do
      workshop=workshops(:one)
      user=users(:user)
      booking=Booking.create( :workshop_id => workshop.id, :user_id => user.id)   #create
      booking_duplicate=Booking.new( :workshop_id => workshop.id, :user_id => user.id)  #new
      expect(booking_duplicate).not_to be_valid
    end
  end


end
