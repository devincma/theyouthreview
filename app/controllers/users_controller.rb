class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_authorization, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @grey_bg = true
    set_meta_tags title: @user.first_name + ' ' + @user.last_name,
                  description: @user.about_me,
                  reverse: true,
                  keywords: @user.first_name + ' ' + @user.last_name + ', ' + @user.school + ', The Youth Review, profile, student'
  end

  def edit
    set_meta_tags title: 'Edit profile',
                  reverse: true
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      flash.now[:alert] = 'Try again'
      render :edit
    end
  end

  private

  def check_authorization
    unless current_user.slug == params[:id]
      redirect_to user_path
    end
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :cover, :avatar, :school, :country, :link, :about_me)
  end

end
