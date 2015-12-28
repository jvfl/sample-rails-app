class UserController < ApplicationController

	#Make sure that the user is authenticated before proceeding.
	before_action :authenticate_user!, only: [:index]

	def index
	end

end
