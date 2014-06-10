class UsersController < ApplicationController

    def show
        @user=User.new
    end

    def new
        @user = User.new
    end

    def index
        @sda = "feaas"
    end

    def create
        @users = User.search(params)
        @verification = User.verification(params)
        @sample = User.sample
    end

    def edit

    end

    def update

    end

    def destroy

    end
end