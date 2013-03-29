class EventsController < ApplicationController
  skip_filter :require_login, only: [:index]

  def index
    if params[:q] && !params[:q].blank?
      term = params[:q].split(/(\d+)/).join(' ')
      @events = Event.search(term).paginate(page: params[:page], per_page: Event.per_page).upcoming
      if @events.size == 0
        flash[:error] = "Sorry, there were no results for your query '#{params[:q]}'."
        redirect_to search_path
      end
    else
      @events = Event.upcoming
    end
  end

  def new
    @event = Event.new
    @courses = current_user.courses
  end

  def create
    @user = User.find(params[:id])
    @course = Course.find(params[:course_id])
    @event = Event.new(params[:event])
    if @event.course_name.nil?
      @event.course_name = @course.name
    else
      @event.course_name += " #{@course.name}"
    end
    if @event.course_abbr.nil?
      @event.course_abbr = @course.abbr
    else
      @event.course_abbr += " #{@course.abbr}"
    end
    if @event.course_short_code.nil?
      @event.course_short_code = @course.short_code
    else
      @event.course_short_code += " #{@course.short_code}"
    end
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