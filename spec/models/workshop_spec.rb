require 'rails_helper'

RSpec.describe Workshop, type: :model do
  fixtures :all

  context 'validations' do

    context 'name' do
      it "it cannot be empty" do
        #workshop = Workshop.new(name: "").save
        #expect(workshop).to eq(false)
        #or:
        workshop = Workshop.new(name: "")
        expect(workshop).not_to be_valid
      end
      it "it cannot be empty" do
        w=workshops(:one)
        w.name=""
        expect(w).not_to be_valid
      end
    end

    context 'number of partecipants' do
      it "cannot be empty" do
        workshop = Workshop.new(name: "")
        expect(workshop).not_to be_valid
      end
      it "cannot be negative" do
        workshop=Workshop.new(name: "WName", max_partecipants: -1)
        expect(workshop).not_to be_valid
      end
      it "must be positive" do
        workshop2=Workshop.new(name:"WName", max_partecipants: 10)
        expect(workshop2).to be_valid
      end
    end

    it "ensures presence of name and a positive number of partecipants" do
      workshop2=Workshop.new(name:"WName", max_partecipants: 10).save      
      expect(workshop2).to eq(true)
    end

    it "cannot be created if date is in the past" do
      workshop2=Workshop.new(name:"WName", max_partecipants: 10, date: Date.yesterday.to_s )      
      expect(workshop2).not_to be_valid
    end


  end

  context "associations" do
    it "has many reviews" do
      w= workshops(:two)
      expect(w.reviews).to match_array([reviews(:rv1), reviews(:rv2)])
    end

    it "workshop one has one booking" do
      w= workshops(:one)
      expect(w.bookings.count).to eq(1)
    end
    it "workshop two has many bookings" do
      w= workshops(:two)
      expect(w.bookings).to match_array([bookings(:booking2), bookings(:booking3)])
    end
  end

    it "returns workshop organizer name" do
        w=workshops(:one)
        expect(User.find(w.organizer_id).username).to eq('username2')
        #expect(User.find(w.organizer_id).username).to eq(users(:organizer).username)
    end
    it "returns workshop organizer id" do        
        w=workshops(:one)
        expect(w.organizer_id).to eq(users(:organizer).id)
    end

end
