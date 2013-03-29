class PagesController < ApplicationController
  skip_before_filter :require_login, :except => [:settings]

  def home
  end

  def start
  end

  def settings
    @courses = Course.all
  end

  def login
  end
  
end
