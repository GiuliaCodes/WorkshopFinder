class WorkshopsController < ApplicationController
  before_action :set_workshop, only: %i[ show edit update destroy ]

  before_action :has_user, :only => [:new, :create]


  # GET /workshops or /workshops.json
  def index
    base=Workshop

    if (params[:sort_order] != nil)
      case params[:sort_order]
      when "date"
        base=base.order(params[:sort_order])
      end
    end

    #if (params[:search_by_city] != nil || params[:search_by_category] != nil )
      if params[:search_by_city] && params[:search_by_city] != ""
        base = base.where('city LIKE ?', "%#{params[:search_by_city]}%")
      end
      if params[:search_by_category] && params[:search_by_category] != ""
        base = base.where("category like ?", "%#{params[:search_by_category]}%")
      end
    #end

    @workshops=base.all
  end

  # GET /workshops/1 or /workshops/1.json
  def show
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
  end

  # POST /workshops or /workshops.json
  def create
    @workshop = Workshop.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: "Workshop was successfully created." }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1 or /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop, notice: "Workshop was successfully updated." }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1 or /workshops/1.json
  def destroy
    @workshop.destroy

    respond_to do |format|
      format.html { redirect_to workshops_path, status: :see_other, notice: "Workshop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workshop_params
      params.require(:workshop).permit(:name, :category, :city, :date, :time, :length, :max_partecipants, :price, :location, :description)
    end

    protected
      def has_user
        unless current_user
          flash[:notice] = 'You must be logged in to organize a workshop.'
          redirect_to root_path and return
        end
    end

end
