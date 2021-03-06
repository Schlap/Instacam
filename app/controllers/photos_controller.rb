class PhotosController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @photos = Photo.all.reverse
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @user = User.find(current_user)
    @photo = @user.photos.new(photo_params)
  if @photo.save
    redirect_to photos_path
  else
    render 'new'
   end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to '/photos'
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = 'Photo deleted successfully'
    redirect_to '/photos'
  end

  def photo_params
    params.require(:photo).permit(:name, :image)
  end
end
