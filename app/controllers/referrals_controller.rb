class ReferralsController < ApplicationController
  before_action :check_session
  before_action :set_referral, only: [:update, :edit, :destroy, :show]
  before_action :check_correct_owners, only: [:show, :edit, :update]
  before_action :check_destroy_owners, only:[:destroy]
  before_action :determine_status, only: [:update, :edit, :show]
  before_action :store_location #enables linking back
  before_action :check_main_admin, only: [:index, :show]
  before_action :check_level, only: [:index]

  include ApplicationHelper

  #TODO set up params to align with the right owner****
  def index
	  # @search = Referral.search(params[:q])
  	# @referrals = @search.result
    @search = Referral.search(params[:q])
    @referrals = @search.result
    @jobs = Job.all
  end

  def new
    @referral = Referral.new
    if !params[:ref_type].nil?
      @job = Job.find(params[:job_id])
      @ref_type = params[:ref_type]
    else
      redirect_to jobs_path, notice: "Please select a job to create a referral"
    end
   # @your_name = current_user.first_name && current_user.last_name || ""
 end

  def create
  # need to move check_whitelist to models
  # binding.pry
   referral = Referral.new(referral_params)
   admin = referral.job.admin
   set_requester(referral)
   if referral.check_email(@requester) #protected method to check if there is a self-referral.
     if referral.save
       # binding.pry
       if referral.ref_type == "refer"
         ReferralMailer.deliver_ref_email(referral)
         check_whitelist(referral)
         redirect_to jobs_path, notice: "Success. Your referral has been created. An email has been sent to confirm interest. "
       else
         ReferralMailer.deliver_ask_email(referral, @requester)
         check_whitelist(referral)
         redirect_to jobs_path, notice: "Success. Your referral request has been sent."
       end
     else
       # binding.pry
       flash[:notice] = "Please review your request. You either created this referral already or did not fill out required fields "
       redirect_to session[:return_to]
     end
   else
     flash[:error] = "Sorry, you cannot refer yourself."
     redirect_to jobs_path(:job_id => referral.job_id, :ref_type => referral.ref_type)
   end
  end

  def show
    @referral
    @job = Job.find(@referral.job_id)
    @my_status
  end

  def edit
    @job = Job.find(@referral.job_id)
    @ref_type = @referral.ref_type
    #binding.pry
    @my_status
    #binding.pry
    #TODO move to model
    if @referral.admin_id.nil?
      @user = User.find(@referral.user_id)
      @referrer_FN = @user.first_name
      @referrer_LN = @user.last_name
    else
      @admin = Admin.find(@referral.admin_id)
      @referrer_FN = @admin.first_name
      @referrer_LN = @admin.last_name
    end
  end

  def update
    # binding.pry

    if !@referral.user_id.nil?
      @requester = User.find(@referral.user_id)
    else
      @requester = Admin.find(@referral.admin_id)
    end

    if @referral.check_email(@requester)
      if @referral.update(referral_params)
        if current_admin.nil?
          #binding.pry
          redirect_to current_user
        else
          #binding.pry
          redirect_to current_admin
        end
      else
        flash[:error] = "There was an issue with your update. Please review your updates."
        #TODO FIX ERROR
        render session[:return_to]
      end
    else
      flash[:error] = "There was an issue with your update. Please review your updates."
      #TODO FIX ERROR
      render session[:return_to]
    end
  end

  def destroy
    # binding.pry
    if @referral.destroy
      # binding.pry
      flash[:notice] = "You successfully removed the referral"
      redirect_to session[:return_to]
    else
      # binding.pry
      flash[:notice] = "Referral could not be deleted."
      redirect_to session[:return_to]
    end
  end


  protected

  def set_referral
    @referral = Referral.find(params[:id])
  end

  def set_requester(referral)
    if current_admin.nil?
      @requester = User.find(current_user.id)
      referral.user_id = @requester.id
    else
      @requester = Admin.find(current_admin.id)
      referral.admin_id = @requester.id
    end
  end

  def referral_params
    params.require(:referral).permit(:name, :job_id, :referral_name, :referral_email, :relationship, :additional_details, :linked_profile_url, :status, :github_profile_url, :relevance, :user_id, :admin_id, :ref_type, :status, :referee_name, :referee_email, :personal_note, :is_interested, :is_active)
  end

  #only correct user and admin can destroy
  def check_correct_owners
    if current_admin.nil?
      if @referral.referral_email != current_user.email && @referral.user != current_user
        redirect_to(new_user_session_path, notice: "You cannot view this referral. Please login to the correct account.")
      end
    else
      if @referral.job.admin != current_admin && @referral.admin_id != current_admin.id
        redirect_to(new_user_session_path, notice: "You cannot view this referral. Please login to the correct account.")
      end
    end
  end

  #owner
  def check_destroy_owners
    if @referral.ref_type == "refer"
      check_correct_owners
    else
      redirect_to(new_user_session_path, notice: "You cannot view this referral. Please login to the correct account.") unless @referral.referee_email == current_user.email
    end
  end

  def determine_status
    if current_admin.nil? #user logic checks
      if @referral.user == current_user
        @my_status = "Sender"
      else
        @my_status = "Receiver-U"
      end
    else #admin logic checks
      if @referral.job.admin == current_admin
        @my_status = "Receiver-A"
      else
        @my_status = "Sender"
      end
    end
  end

  def check_session
    if current_user.nil? && current_admin.nil?
      redirect_to(new_user_session_path, notice: "Please sign-in to make referrals")
    end
  end

def check_whitelist(referral)
    if referral.ref_type == "refer"
      unless Whitelist.exists?(:email => params[:referral][:referral_email])
        Whitelist.create(:email => params[:referral][:referral_email], :level => 1)
      end
    else
      unless Whitelist.exists?(:email => params[:referral][:referee_email])
        Whitelist.create(:email => params[:referral][:referee_email], :level => 1)
      end
    end
  end

  def check_main_admin
  #need to update this
    main_admins = ["loritiernan@gmail.com", "info@wekrut.com", "nyc.amy@gmail.com","deaglan1@gmail.com"]

    if !current_admin.nil?
      status = main_admins.select{|email| email == current_admin.email}
    else
      status = []
    end

    redirect_to new_admin_session_path, notice: "You are not an approved admin." if status.empty?
  end

  def check_level
    level = Whitelist.find_by_email(current_admin.email).level
    redirect_to new_admin_session_path, notice: "You do not have sufficient access level to view this page" if level != 3
  end

end
