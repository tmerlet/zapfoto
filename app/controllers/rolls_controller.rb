class RollsController < ApplicationController
  before_action :set_roll, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /rolls
  # GET /rolls.json
  def index
    @rolls = Roll.all
    authorize! :index, @rolls
  end

  # GET /rolls/1
  # GET /rolls/1.json
  def show
    @photo = Photo.new
    @photos = @roll.photos
    authorize! :show, @roll
  end

  # GET /rolls/new
  def new
    @roll = Roll.new
  end

  # GET /rolls/1/edit
  def edit
    authorize! :edit, @roll
  end

  # POST /rolls
  # POST /rolls.json
  def create
    @roll = current_user.rolls.build(roll_params)
    authorize! :create, @roll

    respond_to do |format|
      if @roll.save
        format.html { redirect_to @roll, notice: 'Roll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @roll }
      else
        format.html { render action: 'new' }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rolls/1
  # PATCH/PUT /rolls/1.json
  def update
    authorize! :update, @roll

    respond_to do |format|
      if @roll.update(roll_params)
        format.html { redirect_to @roll, notice: 'Roll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rolls/1
  # DELETE /rolls/1.json
  def destroy
    @roll.destroy
    authorize! :destroy, @roll

    respond_to do |format|
      format.html { redirect_to rolls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roll
      @roll = Roll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roll_params
      params.require(:roll).permit(:name, :size)
    end
end
