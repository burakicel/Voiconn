class WelcomeController < ApplicationController
	def new
		@owner = Owner.new 
		render 'welcome/index'
	end
end
