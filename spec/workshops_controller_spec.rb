require 'rails_helper.rb'

describe WorkshopsController, type: :controller do

    fixtures :all

    context "a user" do
        before :each do
            user = users(:user)
            sign_in user
        end

        it "should create workshops if name and max partecipants are valid" do
            params= { :workshop => {:name => "name", :max_partecipants => 1 }}
            get :create, :params => params
            w=Workshop.where(:name => "name")
            expect(w).not_to be_empty
        end

        it "should not destroy workshops" do
            w=workshops(:one)
            params = {:id => w.id }
            get :destroy, :params=>params
            ww=Workshop.where(:name => "WorkshopName1")
            expect(ww).not_to be_empty
        end

    end

    context "admin" do
        before :each do
            user = users(:admin)
            sign_in user
        end

        it "should be able to destroy workshops" do
            w=workshops(:one)
            params = {:id => w.id }
            get :destroy, :params=>params
            ww=Workshop.where(:name => "WorkshopName1")
            expect(ww).to be_empty
        end

    end

    context "unlogged user" do
        it "unlogged user should not create workshops" do
            params= { :workshop => {:name => "name", :max_partecipants => 1 }}
            get :create, :params => params
            #w=Workshop.where(:name => "name")
            #expect(w).to be_empty
            expect(response).to redirect_to(root_path)
            #expect(flash[:notice]).to match(/You must be logged in to organize a workshop.*/) 
        end
    end

     context "without user role" do
        before :each do
            user = users(:noroles)
            sign_in user
        end

        it "shouldnt be able to create workshops" do        
            params= { :workshop => {:name => "name", :max_partecipants => 1 }}
            get :create, :params => params
            #w=Workshop.where(:name => "name")
           #expect(w).to be_empty
            expect(flash[:alert]).to match(/You are not authorized to organize a workshop*/) 
        end

    end

    context "an organizer" do
        it "cannot edit a workshop if date is in the past" do
            user = users(:another_organizer)
            sign_in user
            workshop= workshops(:two)
            params= { :id=> workshop.id}
            get :edit, :params => params
            expect(flash[:alert]).to match(/This workshop cannot be edited anymore*/) 
        end
    end

    context "workshop one organizer" do
        before :each do
            user = users(:organizer)
            sign_in user
        end
        it "can update own workshop" do
            workshop= workshops(:one)
            params= { :id=> workshop.id, :workshop => { :name => "WorkshopName1Update"}}
            get :update, :params => params
            w=Workshop.find(workshop.id)
            expect(w.name).to eq("WorkshopName1Update")
        end
        it "cannot update anoter organizer's workshop" do
            workshop= workshops(:two)
            params= { :id=> workshop.id, :workshop => { :name => "WorkshopName2Update"}}
            get :update, :params => params
            w=Workshop.find(workshop.id)
            expect(flash[:alert]).to match(/You are not authorized to update this workshop*/) 
        end

    end



end