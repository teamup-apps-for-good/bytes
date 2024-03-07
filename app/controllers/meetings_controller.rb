class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to meetings_path, notice: 'Meeting scheduled successfully.'
    else
      render :new
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:uid, :date, :time, :location, :recurring)
  end
end
