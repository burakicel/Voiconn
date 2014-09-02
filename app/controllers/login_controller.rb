class LoginController < ApplicationController
  def index
  	if params[:login] != nil
  		@message = User.Auth(params[:login][:username],params[:login][:password])
  		if @message == "Success"
  			if params[:login][:username] == "admin"
  				session[:tmp_params] = params
  				cookies[:params] = { value: params, expires: 1.hour.from_now }
          cookies[:username] = params[:login][:username]
  				redirect_to :controller=>:users, :action=>"index"
  			else
  			session[:tmp_params] = params
        cookies[:params] = { value: params, expires: 1.hour.from_now }
        redirect_to :controller => "game", :action => "dashboard"
        cookies[:username] = params[:login][:username]
        	end
  		end
  	end
  end
end
