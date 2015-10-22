class TracksController < ApplicationController

  before_action :check_if_admin, only: [:create, :update, :destroy]

  def new
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.all.sort_by(&:title)
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all.sort_by(&:title)
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])

    @track.destroy
    redirect_to bands_url
  end

  private

  def track_params
    params.require(:track).permit(:title, :album_id, :kind, :lyrics)
  end

end
