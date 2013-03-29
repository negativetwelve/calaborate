class PagesController < ApplicationController

  def home
    if signed_in?

    end
  end

  def start
  end

  def settings
    @courses = Course.all
  end
  
end
