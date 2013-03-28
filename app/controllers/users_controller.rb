class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to root_url
  end

  def add_course
    user = User.find(params[:id])
    course = Course.find(params[:course_id])
    if user.courses.where(id: course.id).count > 0
      flash[:warning] = "You have already added the course #{course.title_name}."
      redirect_to root_url
      return
    end
    user.courses << course
    if user.save
      flash[:success] = "Added #{course.title_name}."
    end
    redirect_to root_url
  end

  def remove_course
    user = User.find(params[:id])
    course = Course.find(params[:course_id])
    user.courses -= [course]
    if user.save
      flash[:error] = "Removed #{course.title_name}."
    end
    redirect_to root_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end