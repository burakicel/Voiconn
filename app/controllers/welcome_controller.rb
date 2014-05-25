class WelcomeController < ApplicationController
	def new
		@owner = Owner.new 
		render 'visitors/new'
	end
end
