class GamemainsController < ApplicationController

    def show
        params = session[:tmp_params]
        if params == nil
            render template: "logins/create"
        else
        @username = (params[:login][:username]).upcase
        @update = Gamemain.update()
        @money = Gamemain.Account(params)
        @Stocks = Gamemain.Stocks(params)
        @numStocks = @Stocks[1]
        @listStocks = @Stocks[0]
        @stockPrices = Gamemain.stockPrice(@Stocks[0])
        @oldStockPrices = Gamemain.oldStockPrice(@Stocks[0])
        session[:tmp_params] = nil
    end
    end

    def new(params)
        @username = (params[:login][:username]).upcase
        @update = Gamemain.update()
        @money = Gamemain.Account(params)
        @Stocks = Gamemain.Stocks(params)
        @numStocks = @Stocks[1]
        @listStocks = @Stocks[0]
        @stockPrices = Gamemain.stockPrice(@Stocks[0])
        @oldStockPrices = Gamemain.oldStockPrice(@Stocks[0])
    end

    def deliver(params)
        activate.haber(params)
    end

    def index
        @username = "feaas"
    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end
end