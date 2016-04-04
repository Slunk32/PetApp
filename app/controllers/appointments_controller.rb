class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  # before_action :check_user_access


  # GET /appointments
  # GET /appointments.json
  def index
    # If user is an pet_owner, show pet_owner's pets' Appointments
    if current_user.user_type == "Pet Owner"
      # finds all the pets of the current user
      pets = current_user.pets
      # creates an empty array that will be stored in instance var appointments
      @appointments = []
      # goes through each pet record for that pet_owner
      pets.each do |pet|
        # and then goes through each record of that pet_owner's pets' appointments
        pet.appointments.each do |appointment|
          # and pushes them (the appointments) in to the empty array @appointments
          @appointments << appointment
        end
      end
    # If user is a pal, show pal's appointments
    elsif current_user.user_type == "Pet Pal"
      @appointments = current_user.appointments
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    if current_user.user_type == "Pet Pal"
      @appointment = Appointment.new
      @appointment.pet = Pet.find(params[:pet_id])
      @appointment.user = current_user
      @hash = Gmaps4rails.build_markers(@appointment.pet.user) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow user.address
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # GET /appointments/1/edit
  def edit
    if current_user.user_type == "Pet Pal"  && @appointment.user == current_user
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # POST /appointments
  # POST /appointments.json
  def create
    if current_user.user_type == "Pet Pal"
      @appointment = Appointment.new#(appointment_params)
      @appointment.date = Date.strptime(appointment_params[:date], '%m/%d/%Y')
      @appointment.pet = Pet.find(params[:pet_id])
      @appointment.user = current_user
      respond_to do |format|
          if @appointment.save
            format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
            format.json { render :show, status: :created, location: @appointment }
          else
            format.html { render :new, notice: 'WRONG!' }
            format.json { render json: @appointment.errors, status: :unprocessable_entity}
          end
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    if current_user.user_type == "Pet Pal" && @appointment.user == current_user
      respond_to do |format|
        if @appointment.update(appointment_params)
          format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
          format.json { render :show, status: :ok, location: @appointment }
        else
          format.html { render :edit }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    if current_user.user_type == "Pet Pal" && @appointment.user == current_user
      @appointment.destroy
      respond_to do |format|
        format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date, :pet_id, :user_id)
    end
end
