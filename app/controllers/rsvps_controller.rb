class RsvpsController < ApplicationController

  def attend
    @user = current_user
    @event = Event.find(params[:event_id])
    unless @event.nil?
      if Rsvp.attend(@user, @event)
        flash[:success] = "You are attending #{@event.name}."
      else
        flash[:notice] = "You are already attending #{@event.name}."
      end
    end
    redirect_to :back
  end

  def decline

  end

  def maybe
    @user = current_user
    @event = Event.find(params[:event_id])
    unless @event.nil?
      if Rsvp.maybe(@user, @event)
        flash[:notice] = "You might attend #{@event.name}."
      else
        flash[:notice] = "You have already indicated that you might go to #{@event.name}."
      end
    end
    redirect_to :back
  end
end