class Activate < ActiveRecord::Base 

	def self.username(parameters)
		bur = Activate.decode(Activate.encode(parameters[:login][:username]))
	end

	def self.encode (username)
        limit = username.length-1
        code = ""
        for counter in 0..limit
            code += (username[counter].ord+1).chr + (Random.rand(9).to_s)
        end

    	return code
    end

    def self.decode(code)
    	limit = code.length-1
    	username = ""
    	for counter in (0..limit).step(2)
      		username += (code[counter].ord-1).chr
    	end

    	return username
  	end

    def self.status(username,password,verification)
        if Activate.decode(verification) == username
            conn = Connection.Connect()
            command = "SELECT password FROM users WHERE username='"+username+"';"
            res = conn.exec(command)
            if res[0]["password"].to_s == password
                command2 = "UPDATE users SET activation=true WHERE username='"+username+"';"
                res2 = conn.exec(command2)
                hey = conn.close()
                return "Success"
            else
                hey = conn.close()
                return "Fail"
            end
        else
            return "Fail"
        end
    end
end
