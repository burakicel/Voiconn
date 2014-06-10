class RegistersController < ApplicationController
	
	def new
		@owner = Owner.new
		render 'welcome/new'
	end

	def create
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		hey = conn.close()
  	end

  	def createUser
  		username = params[:register][:username]
		conn = PGconn.connect("ec2-5dsae-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		hey = conn.close()
  	end

  	def show
		das = "Hey"
  	end
end