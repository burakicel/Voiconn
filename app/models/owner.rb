require 'pq'

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

	def database_exists?(database_name)
  		conn = PG.connect(:dbname => 'postgres')
  		res = conn.exec("SELECT datname FROM pg_database").values.flatten
  		res.include?(database_name)
	end

	def check
		check = database_exists?('yellow')
	end


end