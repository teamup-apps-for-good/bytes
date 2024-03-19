class MeetingsController < ApplicationController
  before_action :set_uid, only: [:new, :create]

  def index
    @meetings = Meeting.all
    @user = User.find(session[:user_id])
    @current_uid = current_user.uid
  end

  def new
    @meeting = Meeting.new(uid: @current_uid)
  end

  def create
    @meeting = Meeting.new(meeting_params.merge(uid: @current_uid))
    if @meeting.save
      redirect_to meetings_path, notice: 'Meeting scheduled successfully.'
    else
      render :new
    end
  end

  def destroy
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
    puts "MEETING: " + @meeting.to_s
    if @meeting
      if @meeting.destroy
        redirect_to meetings_path, notice: 'Meeting deleted successfully.'
      else
        redirect_to meetings_path, notice: 'Error: Meeting not deleted.'
      end
    else
      puts "DOESNT GO THROUGH"
      redirect_to meetings_path, notice: 'Error: Meeting not found.'
    end
  end

  private

  def set_uid
    @current_user = User.find(session[:user_id])
    @current_uid = current_user.uid
  end

  def meeting_params
    params.require(:meeting).permit(:date, :time, :location, :recurring)
  end
end
