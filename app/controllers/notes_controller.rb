class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    @note.save

    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])
    track = @note.track

    if @note.user = current_user || admin?
      @note.destroy
      redirect_to track_url(track)
    else
      render text: "You can't delete that note!", status: :forbidden
    end
  end


  private

  def note_params
    params.require(:note).permit(:content, :track_id)
  end

end
