class MeetingsController < ApplicationController
  before_action :set_uid, only: [:new, :create]

  def index
    @meetings = Meeting.where(accepted: false)
    @user = User.find(session[:user_id])
    @current_uid = current_user.uid
    @user_meetings = Meeting.where(accepted: true).where("uid = ? OR accepted_uid = ?", @current_uid, @current_uid)
  end

  def new
    @meeting = Meeting.new(uid: @current_uid)
  end

  def create
    @user = User.find(session[:user_id])
    @current_uid = current_user.uid
    @meeting = Meeting.new(meeting_params.merge(uid: @current_uid, accepted: false))

    if @meeting.save
      puts "MEETING SCHEDULED"
      redirect_to meetings_path, notice: 'Meeting scheduled successfully.'
    else
      logger.error "NOT SCHEDULED: #{@meeting}"
      logger.error "Validation errors: #{@meeting.errors.full_messages}"

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

  def accept_meeting
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
    if @meeting
      @meeting.update(accepted: true, accepted_uid: @current_uid)
      redirect_to meetings_path, notice: 'Meeting accepted.'
    end
  end

  def unaccept_meeting
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
    if @meeting
      @meeting.update(accepted: false, accepted_uid: nil)
      redirect_to meetings_path, notice: 'Meeting unaccepted.'
    end
  end

  private

  def set_uid
    @current_user = User.find(session[:user_id])
    @current_uid = current_user.uid
  end

  def meeting_params
    params.require(:meeting).permit(:date, :time, :location, :recurring, :accepted)
  end
end
