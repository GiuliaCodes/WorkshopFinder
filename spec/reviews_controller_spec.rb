require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  #pending "add some examples to (or delete) #{__FILE__}"

  fixtures :all

  context "a partecipant" do
    before :each do
      p= users(:partecipant)
      sign_in p
    end

    it "cannot review a workshop if workshop date is in the future" do
      workshop=workshops(:one)
      params= { :controller=>"reviews", :workshop_id => workshop.id}
      get :new, :params => params
      expect(flash[:alert]).to match(/It's too soon to review this workshop. It will take place on .*/) 

      #analogo per create:
      #params= { :controller=>"reviews", :workshop_id => workshop.id, :review => {:description => "text"} }
      #get :create, :params => params
      #rv=Review.where(:description => "text")
      #expect(rv).to be_empty
      #expect(flash[:alert]).to match(/It's too soon to review this workshop. It will take place on .*/) 
    end

    it "can review a workshop if it is in the past" do
      workshop=workshops(:three)
      params= { :controller=>"reviews", :workshop_id => workshop.id, :review => {:description => "text"} }
      get :create, :params => params
      rv=Review.where(:description => "text").first
      expect(workshop.reviews).to include(rv)
    end

    it "can destroy own review" do
      rv=reviews(:rv1)
      params = {:workshop_id => rv.workshop_id, :id => rv.id, :controller =>reviews }
      get :destroy, :params=>params
      rev=Review.where(:workshop_id => 2, :user_id => 3)
      expect(rev).to be_empty
    end

    it "cannot destroy another user's review" do
      rv=reviews(:rv2)
      params = {:workshop_id => rv.workshop_id, :id => rv.id, :controller =>reviews }
      get :destroy, :params=>params
      #rev=Review.where(:workshop_id => 2, :user_id => 8)
      #expect(rev).not_to be_empty
      expect(flash[:alert]).to match(/You are not authorized to delete this review!*/)
    end

  end

  context "a user who is not partecipant" do
    it "cannot review a workshop" do
      user=users(:noroles)
      sign_in user 
      workshop=workshops(:two)
      params= { :controller=>"reviews", :workshop_id => workshop.id}
      get :new, :params => params
      expect(flash[:alert]).to match(/You are not authorized to review this workshop */)

    end
  end

  context "an admin" do
    it "can destroy reviews from other users" do
      admin= users(:soloadmin)
      sign_in admin

      rv1=reviews(:rv1)
      params1 = {:workshop_id => rv1.workshop_id, :id => rv1.id, :controller =>reviews }
      
      rv2=reviews(:rv2)
      params2 = {:workshop_id => rv2.workshop_id, :id => rv2.id, :controller =>reviews }

      get :destroy, :params=>params1
      get :destroy, :params=>params2
      
      expect(Workshop.find(2).reviews).to be_empty
      
    end
  end




end
