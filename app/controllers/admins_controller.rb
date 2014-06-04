class AdminsController < ApplicationController
before_action :authenticate_admin!, only: [:show, :index]
before_action :set_admin, only: [:show, :update, :destroy]
before_action :correct_admin, only: [:show, :update, :edit, :destroy]
before_action :check_main_admin, only: [:index]
# before_action :clear_search_index, :only => [:show]

  include ApplicationHelper

  def index
    @jobs = Job.all
    @search = Referral.search(params[:q])
    @referrals = @search.result
    @sorted_referrals = @referrals.select{|x| x.ref_type == "refer"}.paginate(page: params[:page], per_page: 10)
    @admins = Admin.new
  end



  def show
    @jobs = @admin.jobs
    @search = Referral.search(params[:q])
    # binding.pry
    if @jobs.count > 0
      @referrals = @search.result.select{|x| x.job.admin == @admin}

      @select_referrals = @referrals.select{|x| x.ref_type == "refer" && x.is_interested == true}
      @sorted_referrals = @select_referrals
      # .paginate(:page => params[:page])
      #is_interested & pending status check
      @select_pending_referrals = @admin.referrals.select{|x| x.status == "pending" && x.is_interested == true}
      @pending_referrals = @select_pending_referrals
      # .paginate(:page => params[:page])

      @pending_count = @pending_referrals.count

      @has_ref = has_any(@pending_count)
    end
  end

  def destroy
    @admin.destroy
    redirect_to new_admin_registration_path, notice: "You successfully deleted your account. We hope you will sign-up with us again"
  end

  protected

  def set_admin
      @admin = Admin.find(params[:id])
    end

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :company, :email, :password, :password_confirmation, :remember_me, :encrypted_password, :industry, :image, :image_cache, :remote_image_url, :remove_image)
  end

  def correct_admin
    admin = Admin.find(params[:id])
    redirect_to new_admin_session_path, :error => "You cannot view that account because you're not the correct admin. Please login to the correct account." unless admin == current_admin
  end

  def check_main_admin
  #need to update this
    main_admins = ["loritiernan@gmail.com", "info@wekrut.com", "nyc.amy@gmail.com","deaglan1@gmail.com"]
    status = main_admins.select{|id| id == current_admin.email}
    redirect_to new_admin_session_path, error: "You are not an approved admin whitelister" if status.empty?
  end

  #TODO move this method
  def has_any(var)
    var > 0 ? true : false
  end

  #ransack methods
  def search_params
    params[:q]
  end
end
