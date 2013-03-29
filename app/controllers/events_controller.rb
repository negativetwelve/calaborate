class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @courses = current_user.courses
  end

  def create
    @user = User.find(params[:id])
    @course = Course.find(params[:course_id])
    @event = Event.new(params[:event])
    @event.users << @user
    @event.courses << @course
    if @event.save
      flash[:success] = "Created #{@event.name}"
      redirect_to profile_path
    else
      @courses = current_user.courses
      render 'new'
    end
  end

end
