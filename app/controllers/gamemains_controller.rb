class GamemainsController < ApplicationController

    def show
        checker = false
        params = session[:tmp_params] #Parameters passed from the login page

        if params == nil
            if eval(cookies[:params].to_s) == nil
                checker = true #there are no cookies so the login process will be required again
            else
                params = eval(cookies[:params]) #Turns the string parameters into hash for easier access
            end
        end

        #If there are cookies avaible or paramaters passed
        if checker == false

            #For User Profile
            @username = (params['login']['username']).upcase
            @update = Gamemain.update()
            @money = Gamemain.Account(params)

            #For Stock Pricing, The stock price is only calculated when it is requested
            @Stocks = Gamemain.Stocks(params)
            @numStocks = @Stocks[1]
            @listStocks = @Stocks[0]
            @stockPrices = Gamemain.stockPrice(@Stocks[0])
            @oldStockPrices = Gamemain.oldStockPrice(@Stocks[0])

            #Stock News
            @stockNews = Gamemain.stockNews()

            session[:tmp_params] = nil #clear the parameters
       
        else
            render template: "logins/create" #Given that the login process expired, it redirects to the login page
        end
    end

    def new(params)
        #For testing purposes
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