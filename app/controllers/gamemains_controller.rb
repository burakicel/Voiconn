class GamemainsController < ApplicationController

    def show

        checker = false

        params = session[:tmp_params]
        if params == nil
            if eval(cookies[:params].to_s) == nil
                #render template: "logins/create"
                checker = true
            else
                params = eval(cookies[:params])
            end
        end
        if checker == false
            @username = (params['login']['username']).upcase
            @update = Gamemain.update()
            @money = Gamemain.Account(params)
            @Stocks = Gamemain.Stocks(params)
            @numStocks = @Stocks[1]
            @listStocks = @Stocks[0]
            @stockPrices = Gamemain.stockPrice(@Stocks[0])
            @oldStockPrices = Gamemain.oldStockPrice(@Stocks[0])
            session[:tmp_params] = nil
        else
            render template: "logins/create"
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