class WorkshopsController < ApplicationController
  before_action :set_workshop, only: %i[ show edit update destroy ]

  before_action :has_user, :only => [:new, :create]
  before_action :can_edit, :only => [:edit]


  # GET /workshops or /workshops.json
  def index

# con checkbox per sorting
=begin
    base=Workshop

    if (params[:sort_order] != nil)
      case params[:sort_order]
      when "date"
        base=base.order(params[:sort_order])
      end
    end

      if params[:search_by_city] && params[:search_by_city] != ""
        base = base.where('city LIKE ?', "%#{params[:search_by_city]}%")
      end
      if params[:search_by_category] && params[:search_by_category] != ""
        base = base.where("category like ?", "%#{params[:search_by_category]}%")
      end

    @workshops=base.all

=end

#con link per sorting
#=begin
    base=Workshop

    @order=params[:sort_order]
    @city=params[:search_by_city]
    @category=params[:search_by_category]

    if (@order != nil && @order != "")
      case @order
      when "date"
        base=base.order(@order)
      end
    end

    if @city && @city != ""
      base = base.where('city LIKE ?', "%#{@city}%")
    end
    if @category && @category != ""
      base = base.where("category like ?", "%#{@category}%")
    end

    @workshops=base.all
#=end

  #flash[:notice] = "params: "+@city.to_s+" "+@category.to_s+" "+@order.to_s
  
  end

  # GET /workshops/1 or /workshops/1.json
  def show
    if user_signed_in?
    @booking= Workshop.find(params[:id]).bookings.where(user_id:current_user.id).first
    end
  end

  # GET /workshops/new
  def new
    authorize! :create, Workshop, :message => "You are not authorized to organize a workshop"

    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
    authorize! :update, @workshop, :message => "You are not authorized to edit this workshop"

  end

  # POST /workshops or /workshops.json
  def create
    authorize! :create, Workshop, :message => "You are not authorized to organize a workshop"


    @workshop = Workshop.new(workshop_params)
    @workshop.organizer_id= current_user.id

    u=User.find(current_user.id)
    if (!u.is_organizer?)
      u.set_organizer
    end

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: "Workshop was successfully created. You are now an organizer :)" }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1 or /workshops/1.json
  def update

    authorize! :update, @workshop, :message => "You are not authorized to update this workshop"

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

    authorize! :destroy, @workshop, :message => "You are not authorized to destroy this workshop"
    @workshop.destroy

    #bisogna rimuovere il ruolo di organizzatore se non ci sono altri workshop organizzati dall'utente corrispondente
    u=User.find(@workshop.organizer_id)
    if (u.is_organizer? && Workshop.where(organizer_id: @workshop.organizer_id).empty?)
      u.unset_organizer
    end
    
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
      def can_edit
        if (!@workshop.date.blank? and @workshop.date <= Date.today)
          redirect_to workshop_path(@workshop), :alert => "This workshop cannot be edited anymore"
        end
      end

end
