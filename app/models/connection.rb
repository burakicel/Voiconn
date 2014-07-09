class Connection < ActiveRecord::Base 
	def self.Connect()
		conn = PGconn.connect()#Erased for privacy
		return conn
	end

	def self.Disconnect(conn)
		close = conn.close()
	end
end