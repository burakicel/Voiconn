class WelcomesController < ApplicationController
	
	def new
		@owner = Owner.new
		render 'welcome/new'
	end

	def deliver
		das = [:welcome][:subject]
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		res  = conn.exec("INSERT INTO employees (employee_id,last_name,first_name,title) values (8,'Icel','Burak','Voiconn Owner')")
		hey = conn.close()
  	end

  	def create
  		mail = params[:welcome][:subject]
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		id_command = "SELECT id FROM emails WHERE id = (SELECT MAX(id) FROM emails);"
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

