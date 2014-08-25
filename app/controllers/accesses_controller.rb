class AccessesController < ApplicationController
  def destroy
    @access = Access.find(params[:id])
  end
end