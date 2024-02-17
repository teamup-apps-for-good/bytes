class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def show
    @school = School.find(params[:id])
  end

  def new; end

  def edit; end

  #post
  def create
    @school = School.new(school_params)
    flash[:notice] = "#{@school.name} was successfully added."
    redirect_to schools_path
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    flash[:notice] = "#{@school.name} deleted."
    redirect_to schools_path
  end

  def update; end

  def search; end

  def school_params
    params.require(:school).permit(:name, :domain, :logo)
  end
end
