class PetsController < ApplicationController
  # runs set pet method only for these processes: show edit update destory
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  # if user is not signed in then redirects to log in page
  before_action :check_auth
  skip_before_action :authenticate_user!
  # creates methods that are pre-loaded on the page so that we can sort columns
  helper_method :sort_column, :sort_direction

  # runs in before_action
  def check_auth
      unless user_signed_in?
          redirect_to welcome_index_path
      end
  end

  # helper method is run when page is loaded to help sorting
  def index
    @pets = if current_user.user_type == "Pet Owner"
      current_user.pets.order(sort_column + " " + sort_direction)
    else
      Pet.order(sort_column + " " + sort_direction)
    end
  end

  # sorts column in either ascending or descending
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def show
  end

  # only allows Pet Owner's to access create pet page.
  def new
    if current_user.user_type == "Pet Owner"
      @pet = current_user.pets.build
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # only allows Pet Owner to edit a pet
  def edit
    if current_user.user_type == "Pet Owner" && @pet.user == current_user
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # this method runs when you click create pet button - and saves the pet.
  def create
    if current_user.user_type == "Pet Owner"
      @pet = current_user.pets.build(pet_params)
      @pet.name = @pet.name.capitalize
      @pet.breed = @pet.breed.capitalize

      respond_to do |format|
        if @pet.save
          format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
          format.json { render :show, status: :created, location: @pet }
        else
          format.html { render :new }
          format.json { render json: @pet.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # method run when you click "update" and saves changes to pet
  def update
    if current_user.user_type == "Pet Owner" && @pet.user == current_user
      respond_to do |format|
        if @pet.update(pet_params)
          format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
          format.json { render :show, status: :ok, location: @pet }
        else
          format.html { render :edit }
          format.json { render json: @pet.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  # method runs when you click the trashcan symbol and deletes pet from db
  def destroy
    if current_user.user_type == "Pet Owner" && @pet.user == current_user
      @pet.personalities.destroy_all
      @pet.destroy
      respond_to do |format|
        format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to '/', notice: 'You do not have access to this page.'
    end
  end

  private
    #
    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :breed, :size, :age, :zipcode, :image, :description)
    end

    def sort_column
      Pet.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
