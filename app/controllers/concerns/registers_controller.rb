class RegistersController < ApplicationController
	
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
  		res = "hegs"
  	end

  	def show
		das = "Hey"
  	end

end

