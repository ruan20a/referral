class AdminsController < ApplicationController

def index
	@jobs = Job.all
end
end
