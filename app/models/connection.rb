class Connection < ActiveRecord::Base 

	#Connects to the postgres database
	def self.Connect()
		conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
		#conn = PGconn.connect()#Erased for privacy
		return conn
	end
	
end