class EventsController < ApplicationController

  def new
    @event = Event.new
    @courses = Course.all
  end

  def create
    @user = User.find(params[:id])
    @course = Course.find(params[:course_id])
    @event = Event.new(params[:event])
    @event.users << @user
    @event.courses << @course
    if @event.save
      flash[:success] = "Created #{@event.name}"
    end
    redirect_to profile
  end

end
