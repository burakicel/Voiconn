class LoginsController < ApplicationController

    def show
        @login=Login.new
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
            @activate = Activate.new(activate_params)
            if @activate.save
                redirect_to params[:redirect_to] || "/activate"
            end
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