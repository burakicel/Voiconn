class Activate < ActiveRecord::Base 

    #Returns the username, Also tests the encode and decode methods
	def self.username(parameters)
		bur = Activate.decode(Activate.encode(parameters[:login][:username]))
	end

    #Encodes the username into a verification code
	def self.encode (username)
        limit = username.length-1
        code = ""

        #Random verification code generated with username hidden inside
        for counter in 0..limit
            code += (username[counter].ord+1).chr + (Random.rand(9).to_s)
        end

    	return code
    end

    #Decodes the verification code into a username
    def self.decode(code)
    	limit = code.length-1
    	username = ""

        #Decodes until the end of verification code
    	for counter in (0..limit).step(2)
      		username += (code[counter].ord-1).chr
    	end

    	return username
  	end

    #Connects to the database to check information and change the activation setting of the user
    def self.status(username,password,verification)

        #Checks if the verification code belongs to the user
        if Activate.decode(verification) == username
            conn = Connection.Connect() # connects to the server
            command = "SELECT password FROM users WHERE username='"+username+"';"
            res = conn.exec(command)

            #checks the password for validity
            if res[0]["password"].to_s == password
                #changes the activation setting given all information is valid
                command2 = "UPDATE users SET activation=true WHERE username='"+username+"';"
                res2 = conn.exec(command2)
                closer = conn.close() #connection shutdown
                return "Success"
            
            else #When the information is not valid
                hey = conn.close()
                return "Fail"
            end
        else #When the information is not valid
            return "Fail"
        end
    end
end
