class Gamemain < ActiveRecord::Base 

	def self.Account (params)
		command = "SELECT MONEY FROM USERS WHERE USERNAME='"+params[:login][:username]+"';"
		conn = Connection.Connect()
		action = conn.exec(command)
		close = conn.close()

		return action[0]["money"]
	end

	def self.Stocks (params)
		listStocks = ["rsi","eoc","gold","oil"]
		command = "SELECT RSI,EOC,GOLD,OIL FROM USERS WHERE USERNAME='"+params[:login][:username]+"';"
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
			command = "select price1 from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0]
		end
		close = conn.close()
		return stockPriceList
	end
	def self.oldStockPrice (stockList)
		stockPriceList = []
		conn = Connection.Connect()
		for i in 0..stockList.length-1
			command = "select price2 from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0]
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
				command = "SELECT CPRICE,PRICE1,PRICE2,PRICE3,PRICE4,PRICE5,PRICE FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				cprice = action.values[0][0].to_f
				price1 = action.values[0][1]
				price2 = action.values[0][2]
				price3 = action.values[0][3]
				price4 = action.values[0][4]
				price5 = action.values[0][5]
				price = action.values[0][6]

				value = cprice + rand(-changeLimit...changeLimit2)

				command = "UPDATE STOCKS SET CPRICE="+value.to_s+",PRICE1="+cprice.to_s+",PRICE2="+price1+",PRICE3="+price2+",PRICE4="+price3+",PRICE5="+price4+",PRICE6="+price5+",PRICE='"+("$"+values.to_s+price)+"' WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
			end

			command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
			action = conn.exec(command)

			close = conn.close()
			return "Update Needed 5min Benchmark"
		elsif difference > 10.0 && difference<=15.0

			for i in 0...listStocks.length
				command = "SELECT CPRICE,PRICE1,PRICE2,PRICE3,PRICE4 FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				cprice = action.values[0][0].to_f
				price1 = action.values[0][1]
				price2 = action.values[0][2]
				price3 = action.values[0][3]
				price4 = action.values[0][4]

				value = cprice + rand(-changeLimit...changeLimit2)
				value2 = value + rand(-changeLimit...changeLimit2)

				command = "UPDATE STOCKS SET CPRICE="+value2.to_s+",PRICE1="+value.to_s+",PRICE2="+cprice.to_s+",PRICE3="+price1+",PRICE4="+price2+",PRICE5="+price3+",PRICE6="+price4+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
			end

			command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
			action = conn.exec(command)

			close = conn.close()
			return "Update Needed 5min Benchmark"

		elsif difference > 15.0 && difference<=20.0
			return "Update Needed"

		elsif difference > 20.0 && difference<=25.0
			return "Update Needed"
		else
			total = []
			for i in 0...listStocks.length
				command = "SELECT CPRICE FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value = action.values[0][0].to_i
				for q in 0...(difference/5).to_i
					value += rand(-changeLimit...changeLimit2)
				end
				command = "UPDATE STOCKS SET PRICE6="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET PRICE5="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET PRICE4="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET PRICE3="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET PRICE2="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET PRICE1="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value += rand(-changeLimit...changeLimit2)
				command = "UPDATE STOCKS SET CPRICE="+sprintf("%.2f",value)+" WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
				action = conn.exec(command)
			end
			close = conn.close()
			return value
		end
	end
end