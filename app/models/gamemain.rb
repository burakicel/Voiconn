class Gamemain < ActiveRecord::Base 

	def self.Account (params)
		command = "SELECT MONEY FROM USERS WHERE USERNAME='"+params['login']['username']+"';"
		conn = Connection.Connect()
		action = conn.exec(command)
		close = conn.close()

		return action[0]["money"]
	end

	def self.Stocks (params)
		listStocks = ["rsi","eoc","gold","oil"]
		command = "SELECT RSI,EOC,GOLD,OIL FROM USERS WHERE USERNAME='"+params['login']['username']+"';"
		conn = Connection.Connect()
		action = conn.exec(command)
		close = conn.close()

		return [action[0],Gamemain.numStocks(action[0])]
	end

	def self.numStocks (stockList)
		listStocks = ["rsi","eoc","gold","oil"]

		total = 0

		for i in 0..listStocks.length
			total += stockList[listStocks[i]].to_i
		end

		return total
	end

	def self.stockPrice (stockList)
		stockPriceList = []
		conn = Connection.Connect()
		for i in 0..stockList.length-1
			command = "select price from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0].to_s.split('$')[2]
		end
		close = conn.close()
		return stockPriceList
	end
	def self.oldStockPrice (stockList)
		stockPriceList = []
		conn = Connection.Connect()
		for i in 0..stockList.length-1
			command = "select price from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0].to_s.split('$')[3]
		end
		close = conn.close()
		return stockPriceList
	end

	def self.update()
		listStocks = ["RSI","EOC","GOLD","OIL"]
		changeLimit = 0.20
		changeLimit2 = 0.21
		conn = Connection.Connect()
		#command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI';"
		command = "SELECT TIME FROM STOCKS WHERE NAME='RSI'"
		action = conn.exec(command)
		difference = TimeDifference.between(Time.parse(action.values[0][0]), Time.now).in_minutes
		if difference <= 5.0
			return "Update Not Needed" + difference.to_s
		elsif difference > 5.0 && difference<=10.0
			for i in 0...listStocks.length
				command = "SELECT PRICE,PRICE1,PRICE2,PRICE3,PRICE4,PRICE5,PRICE FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				cprice = action.values[0][0].split('$')[1]
				price1 = action.values[0][1]
				price2 = action.values[0][2]
				price3 = action.values[0][3]
				price4 = action.values[0][4]
				price5 = action.values[0][5]
				price = action.values[0][6]

				value = cprice.to_f + rand(-changeLimit...changeLimit2)

				priceOutput = ("$"+sprintf("%.2f",value).to_s+price)

				if priceOutput.length > 255
					priceOutput = priceOutput.from(0).to(254)
				end

				command = "UPDATE STOCKS SET CPRICE="+value.to_s+",PRICE1="+cprice.to_s+",PRICE2="+price1+",PRICE3="+price2+",PRICE4="+price3+",PRICE5="+price4+",PRICE6="+price5+",PRICE='"+priceOutput+"' WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
			end

			command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
			action = conn.exec(command)

			close = conn.close()
			return "Update Needed 5min Benchmark"
		else
			total = []
			for i in 0...listStocks.length
				command = "SELECT PRICE FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value = action.values[0][0].split('$')[2].to_f
				priceOutput = action.values[0][0]
				for q in 0...(difference/5).to_i
					value += rand(-changeLimit...changeLimit2)
					priceOutput = "$"+sprintf("%.2f",value).to_s+priceOutput
				end

				if priceOutput.length > 255
					priceOutput = priceOutput.from(0).to(254)
				end

				command = "UPDATE STOCKS SET PRICE='"+priceOutput.to_s+"' WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
				action = conn.exec(command)
			end
			close = conn.close()
			return value
		end
	end
end