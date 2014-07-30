require 'bcrypt'
class User < ActiveRecord::Base
	include BCrypt
	validates :name, :presence => { :message => "Username cannot be blank" }, uniqueness: true
	validates :password_digest, :presence => { :message => "Password cannot be blank" }
end
