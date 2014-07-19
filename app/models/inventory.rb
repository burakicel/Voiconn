class Inventory < ActiveRecord::Base 

	@listStocks = ["rsi","eoc","gold","oil"]

	## INSERTION SORT METHOD##
	def  self.graphData(listStocks,allPrice)
		graphData = []
		allPrice = allPrice.map{|e| e.gsub(/ /,'')}

		for q in 0..6
			totalWorth = 0
		for i in 0...@listStocks.length
			numStocks = listStocks[@listStocks[i]].to_i
			price = allPrice[allPrice.index(@listStocks[i].upcase)+1].to_s.split('$')[2+q].to_f
			totalWorth += numStocks*price
		end
		graphData.push([(Time.now() - (q*5)*60).to_s,sprintf("%.2f",totalWorth)])
		end

		return graphData
	end

	def self.allPrice()
		command = "SELECT name,price FROM STOCKS;" #sql command
		conn = @connection
		action = conn.exec(command)
		close = conn.close()
		return action.values.flatten
	end

	#Returns the Users Stock Inventories
	def self.Stocks (params)
		@connection = Connection.Connect()
		stocks = (@listStocks*",").upcase #String that will be used in the sql command
		command = "SELECT "+stocks+" FROM USERS WHERE USERNAME='"+params['login']['username']+"';" #sql command
		conn = @connection
		action = conn.exec(command)
		return [action[0],Inventory.numStocks(action[0])]
	end

		#Returns the Current Worth of each stock
	def self.stockPrice (stockList)
		conn = @connection
		command = "SELECT NAME,PRICE FROM STOCKS;"
		action = conn.exec(command)
		hey = action.values.flatten.map{|e| e.gsub(/ /,'')}
		stockPriceList = []

		#Goes through each stock
		for i in 0...stockList.length
			stockPriceList[i] = hey[hey.index(stockList.keys[i].upcase)+1].to_s.split('$')[2]
		end

		return stockPriceList
	end

	#Returns the total quantity of stocks that the user owns
	def self.numStocks (stockList)
		total = 0

		#Goes through each stock and calculates the total quantity
		for i in 0..@listStocks.length
			total += stockList[@listStocks[i]].to_i
		end

		return total
	end

end