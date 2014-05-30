class WhitelistsController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_main_admin
  before_action :set_whitelist, only: [:edit, :update, :show, :destroy]

  def index
    @whitelist = Whitelist.all
  end

  def new
    @whitelist = Whitelist.new
  end

  def create
    whitelist = Whitelist.new(whitelist_params)
    if whitelist.save
      redirect_to whitelists_path, notice: 'Email successfully added to whitelist'
      WhitelistMailer.deliver_confirmation(whitelist.email, whitelist.is_admin)
    else
      redirect_to whitelists_path, notice: "Email #{whitelist.email} could not be added because it already exists"
    end
  end

  def edit
    @whitelist
  end

  def update
    if @whitelist.update(whitelist_params)
      redirect_to whitelists_path, notice: 'Email updated'
    else
      render action: 'edit'
    end
  end

  def show
    @whitelist
  end

  def destroy
    if @whitelist.destroy
      redirect_to whitelists_path, notice: "You successfully removed the email from the whitelist"
    else
      render action: 'edit'
    end
  end


  protected

  def whitelist_params
    params.require(:whitelist).permit(:email, :is_admin)
  end

  def set_whitelist
    @whitelist = Whitelist.find(params[:id])
  end


  def check_main_admin
  #need to update this
    main_admins = ["loritiernan@gmail.com", "info@wekrut.com", "nyc.amy@gmail.com","deaglan1@gmail.com"]
    status = main_admins.select{|email| email == current_admin.email}
    redirect_to new_admin_session_path, error: "You are not an approved admin whitelister" if status.empty?
  end

end