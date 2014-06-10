class Login < ActiveRecord::Base 

	def self.bro
		bur = "fds"
	end

	def self.verification(parameters)
		if parameters[:login] == nil
			hey = ""
		else
			username = parameters[:login][:username]
			password = parameters[:login][:password]

			command = "SELECT * FROM users WHERE username='"+username+"' AND password='"+password+"';"

			conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
			action = conn.exec(command)

			if action.values().length == 1
				command2 = "SELECT * FROM users WHERE username='"+username+"' AND activation=true;"
				action2 = conn.exec(command2)
				close = conn.close()
				if action2.values().length == 1
					message = "Success"
				else
					message = "You need to activate your account!"
				end
			else
				close = conn.close()
				message = "Wrong Username or Password!"
			end
		end
	end
end