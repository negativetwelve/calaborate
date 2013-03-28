class CoursesController < ApplicationController
  
  def index
    @courses = Course.paginate(page: params[:page], per_page: 30)
  end

  def show
    @course = Course.find(params[:id])
  end

end
