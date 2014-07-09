class WelcomesController < ApplicationController
	
	def new
		@owner = Owner.new
		render 'welcome/new'
	end

	def deliver
		das = [:welcome][:subject]
		conn = Connection.Connect()
		res  = conn.exec("INSERT INTO employees (employee_id,last_name,first_name,title) values (8,'Icel','Burak','Voiconn Owner')")
		hey = conn.close()
  	end

  	def create
  		mail = params[:welcome][:subject]
		conn = Connection.Connect()
		res = conn.exec(id_command)
		last_id = (res[0]["id"]).to_i+1
		command = "INSERT INTO emails (id,email) values ("+last_id.to_s+",'"+mail+"');"
		res  = conn.exec(command)
		hey = conn.close()
  	end

  	def show
		das = "Hey"
  	end

end

