class ActivatesController < ApplicationController

    def show
        create
    end

    def new
        @activate = Activate.new
    end

    def deliver(params)
        activate.haber(params)
    end

    def index
        @sda = "feaas"
    end

    def create
        if params[:login] == nil
            @username = params[:activate][:username]
            @password = params[:activate][:password]
            @status = Activate.status(@username,@password,params[:activate][:verification])
        else
            @username = Activate.username(params)
            @password = params[:login][:password]
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end
end