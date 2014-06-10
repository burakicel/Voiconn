class User < ActiveRecord::Base 

	hey = "ADSAds"

		def self.verification(parameters)
			password1 = parameters[:user][:password]
			password2 = parameters[:user][:password2]
			username = parameters[:user][:username]
			email = parameters[:user][:email]

			if username.length > 3

				if email.length > 3

					if password1 == password2

						if password1.length > 5
						conn = PGconn.connect("ec2-54-225-239-184.compute-1.amazonaws.com", 5432, '', '', "de6mutapp7fbf", "wbqmgeaxrzvyzr", "7kZ0Wtu6FyFjgHy7MEG4k2y9Ho")
						command = "SELECT * FROM users WHERE username='"+username+"';"
						command2 = "SELECT * FROM users WHERE email='"+email+"';"
						res  = conn.exec(command)
						res2 = conn.exec(command2)

						if res.values().length == 0
							if res2.values().length == 0
								id_command = "SELECT userid FROM users WHERE userid = (SELECT MAX(userid) FROM users);"
								res3 = conn.exec(id_command)
								last_id = ((res3[0]["userid"]).to_i+1).to_s
								command3 = "INSERT INTO users (userid,username,password,email,money,rsi,eoc,gold,oil,activation) values ("+last_id+",'"+username+"','"+password1+"','"+email+"',500,0,0,0,0,FALSE);"
								res4 = conn.exec(command3)
								hey = conn.close()
								Notifier.gmail_message(parameters).deliver
								output = ["Success! We sent your activation code to the submitted email address.","bg-success","You can login now!"]
							else
								hey = conn.close()
								output = ["This email is already registered!","bg-danger"]
							end
						else
							hey = conn.close()
							output = ["This username is taken!","bg-danger"]
						end
					else
						output = ["Your password must be at least 6 characters long!","bg-danger"]
					end
					else
						output = ["The Password Does Not Match!","bg-danger"]
					end
				else
					output = ["Please enter a proper email address!","bg-danger"]
				end
			else
				output = ["The username must be longer than 3 characters!","bg-danger"]
			end
	end

	def self.search(parameters)
    	hey = parameters[:user][:username]
    end

    def self.sample
    	hey = ["fsdfds","dfds"]
    end
end
