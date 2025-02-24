class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :has_user_and_workshop, :only => [:new, :create]
  before_action :can_be_reviewed, :only => [:new, :create]

  
  # GET /reviews or /reviews.json
  def index
    @workshop=Workshop.find(params[:workshop_id]) 
    @reviews=@workshop.reviews  #solo review del workshop selezionato
    #@reviews = Review.all

  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @workshop=Workshop.find(params[:workshop_id]) 
    @review = @workshop.reviews.find(params[:id]) 
  end

  # GET /reviews/new
  def new
    authorize! :create, Review, message: "You are not authorized to review this workshop!"


    #@workshop = Workshop.where(:id => params[:workshop_id]).first #has_user_and_workshop lo fa gia per new e create
    @workshop=Workshop.find(params[:workshop_id]) #anche cosi
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    authorize! :update, @review, message: "You are not authorized to edit this review!"

    @workshop=Workshop.find(params[:workshop_id])
    @review = @workshop.reviews.find(params[:id]) 
  end

  # POST /reviews or /reviews.json
  def create
    authorize! :create, Review, message: "You are not authorized to review this workshop!"

    @workshop=Workshop.find(params[:workshop_id])  #inutile con has_user_and_workshop. senza, serve qui e in new

    #@review=@workshop.reviews.create(review_params) # dal tutorial rails. 
    #@review.user_id= current_user.id  
    
    #@review=@workshop.reviews.create(description: params[:review][:description], user_id: current_user.id)    #anche così

    #come esercitazione:
    @review = Review.new(review_params)
    @workshop.reviews << @review
    current_user.reviews << @review  

    respond_to do |format|
      if @review.save
        format.html { redirect_to workshop_review_path(@workshop, @review), notice: "Review was successfully created for #{@workshop.name} by #{current_user.username} ." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    authorize! :update, @review, message: "You are not authorized to edit this review!"


    @review = Workshop.find(params[:workshop_id]).reviews.find(params[:id])
    @workshop=Workshop.find(params[:workshop_id])

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to workshop_review_path(@workshop, @review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    authorize! :destroy, @review, message: "You are not authorized to delete this review!"


    @review.destroy

    respond_to do |format|
      format.html { redirect_to workshop_reviews_path, status: :see_other, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:description)
    end

    protected
      def has_user_and_workshop
        unless current_user
          flash[:notice] = 'You must be logged in to leave a review.'
          redirect_to root_path and return
        end
        unless (@workshop = Workshop.where(:id => params[:workshop_id]).first)
          flash[:notice] = 'Review must be for an existing workshop.'
          redirect_to workshops_path and return
        end
      end

      def can_be_reviewed
        if ( Date.current < @workshop.date )
          redirect_to workshop_path(@workshop), :alert => "It's too soon to review this workshop. It will take place on "+@workshop.date.to_s
        end
      end

end
