class ProfilesController < ApplicationController
	def index
		redirect_to articles_path
	end
	
	def show
		@user = User.find(params[:id])
	end
end
