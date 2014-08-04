class CompaniesController < ApplicationController
  before_action :check_access_level

  def index
    @companies = Company.all
  end



  #Method only allows super admins to go in
  private
  def set_company
      @company = Company.find(params[:id])
  end


  def check_access_level
  end
end