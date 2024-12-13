require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"


  fixtures :all
  context "validations" do
    it "uniqueness" do
      workshop=workshops(:two)
      user=users(:partecipant)
      #expect(user.reviews).not_to be_empty
      rv_duplicate=Review.new( :workshop_id => workshop.id, :user_id => user.id, :description => "ReviewDescriptionTest")
      expect(rv_duplicate).not_to be_valid
    end

  end


end
