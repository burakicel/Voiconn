class LoginsController < ApplicationController

    def show
        render template: "logins/create"
    end

    def new
        @login = Login.new
    end

    def index
        @sda = "feaas"
    end

    def create
        @verification = Login.verification(params)
        if (@verification == "You need to activate your account!")
            redirect_to :controller => "activate", :action => "create", :params => params
        elsif (@verification == "Success")
            session[:tmp_params] = params
            redirect_to gamemain_path
            #redirect_to :controller => "gamemain", :action => "create", :params => params
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    def activate_params
        params.require(:login).permit(:username)
    end
end