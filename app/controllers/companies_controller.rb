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

  def company_params
      params.require(:company).permit(:name, :address_line_1, :address_line_2, :city, :state, :country, :postal_code, :level, :description, :industry, :image, :image_cache, :remote_image_url, :remove_image)

  end
end