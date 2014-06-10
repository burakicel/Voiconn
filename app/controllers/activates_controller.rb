class ActivatesController < ApplicationController

    def show
        create
    end

    def new(params)
        @activate = Activate.haber(params)
    end

    def index
        @sda = "feaas"
    end

    def create(params)
        @com = Activate.bro(params)
    end

    def haber(params)
        @com = Activate.bro(params)
    end

    def edit

    end

    def update

    end

    def destroy

    end
end