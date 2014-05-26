require 'pg'
class Owner
	def name
		name = 'Burak Icel'
	end

	def message
		message = 'Welcome to the Voiconn!'
	end

	def description
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		res  = conn.exec('SELECT 1 AS a, 2 AS b, NULL AS c')
		description = 'Voiconn is a stock trading simulation that will train new investors.'
		hey = res(0,2)
	end

end