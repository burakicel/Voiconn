require 'pg'
class Owner
	def name
		name = 'Burak Icel'
	end

	def message
		message = 'Welcome to the Voiconn!'
	end

	def description
		description = 'Voiconn is a stock trading simulation that will train new investors.'
	end

	def companies
		conn = Connection.Connect()
		res  = conn.exec('SELECT last_name FROM employees')
		hey = conn.close()
		
		ary = Array.new
		counter = 0

		while counter < 7  do
   			ary.push(res[counter]["last_name"])
   			counter += 1
		end

		bea = ary
	end

end
