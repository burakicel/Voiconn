class WelcomeController < ApplicationController
	
	def new
		@owner = Owner.new
		render 'welcome/new'
	end

	def deliver
		das = [:welcome][:subject]


  	end




end

