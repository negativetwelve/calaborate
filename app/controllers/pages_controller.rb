class PagesController < ApplicationController
  skip_before_filter :require_login, :except => [:settings, :suggested]

  def home
  end

  def start
  end

  def settings
    @courses = Course.all
  end

  def login
  end

  def autocomplete_courses
    if params[:term]
      term = params[:term].split(/(\d+)/)
      check = ""
      term.each do |t|
        if t.to_i != 0
          check += " " + t
        else
          check += t
        end
      end
      @courses = Course.search(check).map(&:name).compact.reject(&:blank?)
    else
      @courses = Course.all.map(&:name).compact.reject(&:blank?)
    end
    @courses = @courses.map{|c| c.humanize.titleize }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search

  end

  def suggested
    @user = current_user
    @courses = current_user.courses
    @events = {}
    @courses.each do |course|
      @events[course.id] = course.events
    end
  end

  def coming_soon

  end
  
end
