class Notifier < ActionMailer::Base
  default from: "Voiconn Team"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.gmail_message.subject
  #
  def gmail_message(parameters)
    email = parameters[:user][:email].to_s
    username = parameters[:user][:username].to_s
    @greeting = "Hi"
    @username = username
    @verification = encode(username)
    mail to: email, subject: "Confirm your Voiconn Account"
  end

  def encode (username)
    limit = username.length-1
    code = ""
    for counter in 0..limit
      code += (username[counter].ord+1).chr + (Random.rand(9).to_s)
    end

    return code
  end

  def decode(code)
    limit = code.length-1
    username = ""
    for counter in (0..limit).step(2)
      username += (code[counter].ord-1).chr
    end

    return username
  end
end
