class MeetingsController < ApplicationController
  before_action :set_uid, only: [:new, :create]
  helper_method :get_this_week

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

  def edit
    @user = User.find(session[:user_id])
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
  end

  def update
    @meeting = Meeting.find_by(id: params[:id])
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to '/meetings', notice: "Your meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
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

  def get_next_week(id)
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: id)
    original_date = @meeting.date
    @date = original_date + 7
  end

  def complete_transaction
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
    if @meeting.recurring
      @meeting.update(date: get_next_week(@meeting.id), accepted: false, accepted_uid: nil)
      redirect_to meetings_path, notice: 'Meeting Completed.'
    else
      @meeting.destroy
      redirect_to meetings_path, notice: 'Meeting Completed.'
    end
  end

  def donor_cancel
    @current_uid = current_user.uid
    @meeting = Meeting.find_by(id: params[:id])
    if @meeting.recurring == true
      @meeting.update(accepted: false, accepted_uid: nil)
      redirect_to meetings_path, notice: 'Meeting cancelled. Recurring meeting posted.'
    else
      @meeting.destroy
      redirect_to meetings_path, notice: 'Meeting cancelled.'
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
