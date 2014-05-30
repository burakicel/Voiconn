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
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
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
