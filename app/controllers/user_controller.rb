class UserController < ApplicationController

	#Make sure that the user is authenticated before proceeding.
	before_action :authenticate_user!

	def index
	end

end
