class GameController < ApplicationController

  
  def dashboard
    @user = User.find_by_name(cookies[:username])
    @personalStock = User.stockList(cookies[:username],1)
    @stockList = User.stockData(@personalStock)
    @stockListHash = Stock.convertHash(User.stockList(cookies[:username],1))
    @numStocks = Stock.stockCount(User.stockList(cookies[:username],1))
    @sumStocks = Stock.sumStocks(@stockList,@personalStock)
    @news = Stock.news()
  end

  def inventory
    @user = User.find_by_name(cookies[:username])
    @personalStock = User.stockList(cookies[:username],1)
    @stockList = User.stockData(@personalStock)
    @sumStocks = Stock.sumStocks(@stockList,@personalStock)

    if params[:graphSetting] == nil
    @stockHistory = Stock.stockHistory(@personalStock,@sumStocks[-1],7)
    else
    @stockHistory = Stock.stockHistory(@personalStock,@sumStocks[-1],params[:graphSetting].to_i)
    end
  end

  def buy
    require 'yahoo_finance'
    @stocks = Stock.stocksPopular()
    @chosenStock = params
    if params["game"] != nil
      @stockData = Stock.data(@chosenStock["game"]["stock"])
      @stock = Stock.info(@chosenStock["game"]["stock"])
      @change = [@stock[1],@stock[2]]
      @stock = @stock[0]
    end

    if params["total_price"] != nil
      @info = User.buyStock(params["quantity"],params["stock"],cookies[:username])
    end
  end

  def sell
    @stocks = User.stockList(cookies[:username],2)
    @chosenStock = params
    if params["game"] != nil
      @stockData = Stock.data(@chosenStock["game"]["stock"])
      @stock = Stock.info(@chosenStock["game"]["stock"])
      @change = [@stock[1],@stock[2]]
      @stock = @stock[0]
      @sellData = User.sellData(cookies[:username],@chosenStock["game"]["stock"],@stock.bid)
    end
    if params["total_price"] != nil
        @info = User.sellStock(params["quantity"],params["stock"],cookies[:username])
      end
  end

  def message
  end

  def highscore
    @topUsers = User.topUsers()
  end

end
