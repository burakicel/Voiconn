class Connection < ActiveRecord::Base 

	#Connects to the postgres database
	def self.Connect()
		conn = PGconn.connect()#Erased for privacy
		return conn
	end
	
end