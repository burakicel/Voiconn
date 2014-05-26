require 'pg'
class Owner
	def name
		name = 'Burak Icel'
	end

	def message
		message = 'Welcome to the Voiconn!'
	end

	def description
		conn = PGconn.open(:dbname => 'yellow')
		description = 'Voiconn is a stock trading simulation that will train new investors.'
	end

end