class WelcomeController < ApplicationController
	
	def new
		@owner = Owner.new
		render 'welcome/new'
	end

end

