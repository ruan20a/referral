class UsersController < ApplicationController
  before_action :signed_in?
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

end
