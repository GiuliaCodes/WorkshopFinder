require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  #pending "add some examples to (or delete) #{__FILE__}"

  fixtures :all

  context "User booking a workshop" do

    before :each do 
      user=users(:user)
      sign_in user
    end

    it "cannot book a workshop if workshop date is in the past" do
      workshop=workshops(:two)
      params= { :controller=>"bookings", :workshop_id => workshop.id}
      get :new, :params => params
      expect(flash[:alert]).to match(/This workshop doesn't accept bookings anymore*/) 
    end

    it "cannot book a workshop if it has max partecipants" do
      workshop=workshops(:one)
      params= { :controller=>"bookings", :workshop_id => workshop.id}
      get :create, :params => params
      expect(flash[:alert]).to match(/the workshop is fully booked*/) 

    end

  end

end
