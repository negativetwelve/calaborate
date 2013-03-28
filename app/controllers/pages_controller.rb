class PagesController < ApplicationController

  def home
    @courses = Course.all
    if signed_in?

    end
  end
  
end
