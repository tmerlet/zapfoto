class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /photos
  # GET /photos.json
  def index
    @roll = Roll.find(params[:roll_id])
    @photos = @roll.photos
    authorize! :index, @photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    authorize! :show, @photo
  end

  # GET /photos/new
  def new
    @roll = Roll.find(params[:roll_id])
    @photo = Photo.new
    authorize! :new, @photo
  end

  # GET /photos/1/edit
  def edit
    @roll = Roll.find(params[:roll_id])
    authorize! :edit, @photo
  end

  # POST /photos
  # POST /photos.json
  def create
    # Decodes uploaded base64 string
    file = uploaded_picture params[:photo][:base_64_photo]

    @roll = Roll.find(params[:roll_id])
    @photo = @roll.photos.build(photo_params)
    @photo.image = file
    authorize! :create, @photo
    
    respond_to do |format|
      if @photo.save
        @roll.automailer(current_user)
        format.html { redirect_to roll_path(@roll), notice: 'Photo was successfully created.' }
        format.json { render json: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    authorize! :update, @photo

    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to roll_photo_path(@photo), notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    authorize! :destroy, @photo
    respond_to do |format|
      format.html { redirect_to roll_photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :latitude, :longitude)
    end

    def uploaded_picture base_64_string
      return unless base_64_string
      base_64_string.gsub!("data:image/png;base64,", "")
      tempfile = Tempfile.new ['upload', 'jpg']
      tempfile.binmode
      tempfile.write(Base64.decode64(base_64_string))
      ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: 'upload.jpg')
    end
end
