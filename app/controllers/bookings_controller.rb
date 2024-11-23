class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]
  #before_action :can_be_booked, only: [:new, :create]   #uncomment to make it so that you cannot book a workshop if it's date has passed

  # GET /bookings or /bookings.json
  def index
    @workshop=Workshop.find(params[:workshop_id])
    @bookings=@workshop.bookings
    #@bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
    @workshop=Workshop.find(params[:workshop_id])
    @booking= @workshop.bookings.find(params[:id])
  end

  # GET /bookings/new
  def new
    @workshop=Workshop.find(params[:workshop_id])
    @booking = Booking.new
  end

  # GET /bookings/1/edit
#  def edit   
#  end

  # POST /bookings or /bookings.json
  def create

    @workshop=Workshop.find(params[:workshop_id])

    if ( Booking.where(workshop_id: @workshop.id).count >= @workshop.max_partecipants)
      redirect_to workshop_path(@workshop), :alert => "the workshop is fully booked"

    else
      #rendi user partecipant

      u=User.find(current_user.id)
      if (!u.is_partecipant?)
        u.set_partecipant
      end

      @booking = @workshop.bookings.create(workshop_id: params[:workshop_id], user_id: current_user.id)
      respond_to do |format|
        if @booking.save
          format.html { redirect_to workshop_booking_path(@workshop, @booking), notice: "Booking was successfully created." }
          format.json { render :show, status: :created, location: @booking }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
#  def update   
#    respond_to do |format|
#      if @booking.update(booking_params)
#        format.html { redirect_to @booking, notice: "Booking was successfully updated." }
#        format.json { render :show, status: :ok, location: @booking }
#      else
#        format.html { render :edit, status: :unprocessable_entity }
#        format.json { render json: @booking.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    authorize! :destroy, @booking, :message => "You cannot delete this booking"


    @booking.destroy

    @workshop=Workshop.find(params[:workshop_id])

    u=User.find(@booking.user_id)
    if (u.is_partecipant? && Booking.where(user_id: @booking.user_id).empty?)
      u.unset_partecipant
    end

    respond_to do |format|
      format.html { redirect_to workshop_path(@workshop), status: :see_other, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.fetch(:booking, {})
    end

    protected
      def can_be_booked
        @workshop=Workshop.find(params[:workshop_id])
        if (Date.current >= @workshop.date )
          redirect_to workshop_path(@workshop), :alert => "This workshop doesn't accept bookings anymore"
        end
      end
end
