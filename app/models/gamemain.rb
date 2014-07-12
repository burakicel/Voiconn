class Gamemain < ActiveRecord::Base 

	#List of the stocks avaible
	@@listStocks = ["rsi","eoc","gold","oil"]
	@@listStocksCap = @@listStocks.map(&:upcase)

	#Returns the Users Balance
	def self.Account (params)
		command = "SELECT MONEY FROM USERS WHERE USERNAME='"+params['login']['username']+"';" #sql command
		conn = Connection.Connect()
		action = conn.exec(command)
		close = conn.close()
		return action[0]["money"]
	end

	#Returns the Users Stock Inventories
	def self.Stocks (params)
		stocks = (@@listStocks*",").upcase #String that will be used in the sql command
		command = "SELECT "+stocks+" FROM USERS WHERE USERNAME='"+params['login']['username']+"';" #sql command
		conn = Connection.Connect()
		action = conn.exec(command)
		close = conn.close()
		return [action[0],Gamemain.numStocks(action[0])]
	end

	#Returns the total quantity of stocks that the user owns
	def self.numStocks (stockList)
		total = 0

		#Goes through each stock and calculates the total quantity
		for i in 0..@@listStocks.length
			total += stockList[@@listStocks[i]].to_i
		end

		return total
	end

	#Returns the Current Worth of each stock
	def self.stockPrice (stockList)
		stockPriceList = []
		conn = Connection.Connect()

		#Goes through each stock
		for i in 0...stockList.length
			command = "select price from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0].to_s.split('$')[2]
		end

		close = conn.close()
		return stockPriceList
	end

	#Returns the Worth of each stock 5 minutes ago
	def self.oldStockPrice (stockList)
		stockPriceList = []
		conn = Connection.Connect()

		#Goes through each stock
		for i in 0..stockList.length-1
			command = "select price from STOCKS where name='"+stockList.keys[i].upcase+"';"
			action = conn.exec(command)
			stockPriceList[i] = action[0].to_s.split('$')[3]
		end

		close = conn.close()
		return stockPriceList
	end

	#Updates the stock prices based on the time differences
	#This way the server is used efficiently
	def self.update()

		#VARIABLES
		listStocks = @@listStocks.map(&:upcase) #capitalizes the stocks names for sql purposes
		
		#The Change Limits (Maximum amount of change allowed in 5 minutes)
		changeLimit = 0.20 #Maximum Drop Allowed
		changeLimit2 = 0.21 #Maximum Increase Allowed

		conn = Connection.Connect() #connects to the database

		#Checks the last time the stocks were updated
		command = "SELECT TIME FROM STOCKS WHERE NAME='RSI'"
		action = conn.exec(command)
		difference = TimeDifference.between(Time.parse(action.values[0][0]), Time.now).in_minutes

		#Updates the stocks prices if the time difference is greater than 5 minutes
		if difference <= 5.0
			return ""
		else
			total = []

			#Updates Each Stock
			for i in 0...listStocks.length
				command = "SELECT PRICE FROM STOCKS WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)
				value = action.values[0][0].split('$')[1].to_f #Splits the string into an array of prices
				priceOutput = action.values[0][0]

				#Randomly Generates new prices based on the time passed
				for q in 0...(difference/5).to_i
					value += rand(-changeLimit..changeLimit2)
					priceOutput = "$"+sprintf("%.2f",value).to_s+priceOutput
				end

				#If the amount of data exceeds the maximum, the old data is erased to create room for the new data
				if priceOutput.length > 255
					priceOutput = priceOutput.from(0).to(254)
				end

				#Updates the stock prices on the database
				command = "UPDATE STOCKS SET PRICE='"+priceOutput.to_s+"' WHERE NAME='"+listStocks[i].to_s+"';"
				action = conn.exec(command)

				#Updates the time on the database
				command = "UPDATE STOCKS SET TIME='"+Time.now.to_s+"' WHERE NAME='RSI'"
				action = conn.exec(command)
			end

			close = conn.close() #connection is closed
			return ""
		end
	end

	#Generate News based on the stock price changes
	def  self.stockNews ()
		conn = Connection.Connect()
		command = "SELECT TIME FROM NEWS WHERE NEWSID=1;"
		action = conn.exec(command)
		difference = TimeDifference.between(Time.parse(action.values[0][0]), Time.now).in_minutes
		numPics = 7

		#if difference > 4
		positiveHeadlines = ["%stock Prices Spike Higher","%stock Stocks Gain Momentum","%stock Shares Up %percentage%","Shares in %stock Jump Over %percentage%"]
		negativeHeadlines = ["%stock Stocks Falls by %percentage%","%stock Plunges %percentage%"]
		growthList = Hash.new{|h,k| h[k] = []}
		differenceList = []

		for i in 0...@@listStocksCap.length
			command = "SELECT PRICE FROM STOCKS WHERE NAME='"+@@listStocksCap[i].to_s+"';"
			action = conn.exec(command)
			prices = action.values[0][0].split('$')

			difference = sprintf("%.2f",prices[1].to_f-prices[-2].to_f).to_f

			differenceList[i] = difference
			growthList[difference][0] = @@listStocksCap[i].to_s
			growthList[difference][1] = sprintf("%.2f",( ((100/prices[-2].to_f)*difference.to_f).abs ))
		end

		differenceList = insertionsort(differenceList)

		if differenceList[-1].to_f != 0
			if differenceList[-1].to_f > 0
				headline = positiveHeadlines[rand(0...positiveHeadlines.length)].gsub("%stock",growthList[differenceList[-1]][0]).gsub("%percentage",growthList[differenceList[-1]][1])
			elsif differenceList[-1].to_f < 0
				headline = negativeHeadlines[rand(0...negativeHeadlines.length)].gsub("%stock",growthList[differenceList[-1]][0]).gsub("%percentage",growthList[differenceList[-1]][1])
			end
			if growthList[differenceList[-1]][0] == "OIL"
				picID = "1"
			elsif growthList[differenceList[-1]][0] = "GOLD"
				picID = "0"
			else
				picID = rand(2..numPics).to_s
			end
			command = "UPDATE NEWS SET STOCKTITLE='"+headline+"',PICID="+picID+" WHERE NEWSID=1;"
			action = conn.exec(command)
		end


		if differenceList[0].to_f != 0
			if differenceList[0].to_f > 0
				headline = positiveHeadlines[rand(0...positiveHeadlines.length)].gsub("%stock",growthList[differenceList[0]][0]).gsub("%percentage",growthList[differenceList[0]][1])
			elsif differenceList[0].to_f < 0
				headline = negativeHeadlines[rand(0...negativeHeadlines.length)].gsub("%stock",growthList[differenceList[0]][0]).gsub("%percentage",growthList[differenceList[0]][1])
			end
			if growthList[differenceList[0]][0] == "OIL"
				picID = "1"
			elsif growthList[differenceList[0]][0] == "GOLD"
				picID = "0"
			else
				picID = rand(2..numPics).to_s
			end
			command = "UPDATE NEWS SET STOCKTITLE='"+headline+"',PICID="+picID+" WHERE NEWSID=2;"
			action = conn.exec(command)
		end
		#end

		images = []
		titles = []

		for i in 0..1
			command = "SELECT PICID,STOCKTITLE FROM NEWS WHERE NEWSID="+(i+1).to_s+";"
			action = conn.exec(command)
			images[i] = "images-"+(action.values[0][0]).to_s+".jpg"
			titles[i] = action.values[0][1].to_s
		end
		close = conn.close()
		return [images,titles]
	end

	def  self.insertionsort(num)
		for j in 1...num.length
			key = num[j]
			i = j - 1
			while i >= 0 and num[i] > key
				num[i+1] = num[i]
				i = i - 1
			end
			num[i+1] = key
		end	
		return num
	end
end