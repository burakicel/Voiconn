class RegistersController < ApplicationController
	
	def new
		render template: "registers/create"
	end

	def create
		conn = Connection.Connect()
		hey = conn.close()
  	end

  	def createUser
  		username = params[:register][:username]
		conn = Connection.Connect()
		hey = conn.close()
  	end

  	def show
		render template: "registers/create"
  	end
end