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
      @rsvp = Rsvp.new(event_id: @event.id, user_id: @user.id, status: 'attending')
      if @rsvp.save
        flash[:success] = "Created #{@event.name}."
        redirect_to my_events_path
      end
    else
      flash[:error] = "Failed to create event. #{@event.errors.full_messages.to_sentence.humanize} #{@rsvp.errors.full_messages.to_sentence.humanize}"
      redirect_to new_event_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    @courses = current_user.courses
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:success] = "#{@event.name} was updated."
      redirect_to my_events_path
    else
      render 'edit'
    end
  end

  def attending
    @user = current_user
  end

end
