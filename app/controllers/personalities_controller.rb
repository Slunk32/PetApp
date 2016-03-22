class PersonalitiesController < ApplicationController
  before_action :set_personality, only: [:show, :edit, :update, :destroy]

  # GET /personalities
  # GET /personalities.json
  def index
    @personalities = Personality.all
  end

  # GET /personalities/1
  # GET /personalities/1.json
  def show
  end

  # GET /personalities/new
  def new
    @personality = Personality.new
    @personality.pet = Pet.find(params[:pet_id])
  end

  # GET /personalities/1/edit
  def edit
  end

  # POST /personalities
  # POST /personalities.json
  def create
    @personality = Personality.new(personality_params)
    @personality.pet = Pet.find(params[:pet_id])
    respond_to do |format|
      if @personality.save
        format.html { redirect_to @personality, notice: 'Personality was successfully created.' }
        format.json { render :show, status: :created, location: @personality }
      else
        format.html { render :new }
        format.json { render json: @personality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personalities/1
  # PATCH/PUT /personalities/1.json
  def update
    respond_to do |format|
      if @personality.update(personality_params)
        format.html { redirect_to @personality, notice: 'Personality was successfully updated.' }
        format.json { render :show, status: :ok, location: @personality }
      else
        format.html { render :edit }
        format.json { render json: @personality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personalities/1
  # DELETE /personalities/1.json
  def destroy
    @personality.destroy
    respond_to do |format|
      format.html { redirect_to personalities_url, notice: 'Personality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personality
      @personality = Personality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personality_params
      params.require(:personality).permit(:trait, :pet_id)
    end
end
