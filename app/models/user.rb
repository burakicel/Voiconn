require 'bcrypt'
class User < ActiveRecord::Base
	include BCrypt
	validates :name, :presence => { :message => "Username cannot be blank" }, uniqueness: true
	validates :password_digest, :presence => { :message => "Password cannot be blank" }
	validates_confirmation_of :password_digest, :message=> "Password confirmation is invalid"
	validates_email_format_of :email, :message => 'Email is not valid'
	

	def self.Auth(username, password)
		user = User.find_by_name(username)
		if user != nil
			if password == user.password_digest
				"Success"
			else
				"Wrong Password"
			end
		else
			"User Does Not Exist"
		end
	end

	def self.stockList(username,state)
		user = User.find_by_name(username)
		stockList = user.stock.split("|")

		if state == 2
			stockList2 = []
			for i in (0...stockList.length).step(3)
				stockList2.push(stockList[i])
			end
			return stockList2
		end

		return stockList

	end

	def self.stockData(list)
		stocks = []

		for i in (0...list.length).step(3)
			stock = StockQuote::Stock.quote(list[i], nil, nil, ['Symbol', 'Bid', 'Change'])
			stocks.push(stock.symbol)
			stocks.push(stock.bid)
			stocks.push(stock.change)
		end

		return stocks
	end

	def self.buyStock(stockQuantity, stockName, username)
		stock = StockQuote::Stock.quote(stockName, nil, nil, ['Symbol', 'Open','Ask'])
		cost = stock.open.to_f * stockQuantity.to_i

		user = User.find_by_name(username)

		if user.balance < cost || stockQuantity.to_i < 0
			return "Not enough funds"
		else
			user.balance -= cost
			stockList = user.stock.split("|").map(&:upcase)

			if stockList.index(stockName) != nil
				stockList[stockList.index(stockName)+1] = (stockList[stockList.index(stockName)+1].to_i+stockQuantity.to_i).to_s
				stockList[stockList.index(stockName)+2] = (stock.open).to_s
			else
				stockList.push(stockName)
				stockList.push(stockQuantity)
				stockList.push(stock.open)
			end

			user.stock = stockList.join('|')
			user.save
			return "Success"
		end

	end

	def self.sellData(username, stockName, stockCurrentPrice)
		sellData = []
		user = User.find_by_name(username)
		stockList = user.stock.split("|")

		sellData.push(stockList[stockList.index(stockName)+1])
		sellData.push(stockList[stockList.index(stockName)+2])
		sellData.push(sprintf("%.2f",(100/sellData[-1].to_f)*(stockCurrentPrice.to_f-sellData[-1].to_f)).to_f)
		if sellData[-1] < 0
			sellData.push("down")
		else
			sellData.push("up")
		end
		return sellData
	end

	def self.sellStock(quantity, stockName, username)
		user = User.find_by_name(username)
		stockList = user.stock.split('|')

		stockIndex = stockList.index(stockName)

		if quantity.to_f > stockList[stockIndex+1].to_f
			return "You don't have that much quantity"
		else
			bid = StockQuote::Stock.quote(stockName, nil, nil, ['Symbol', 'Open','Bid']).bid
			user.balance += bid.to_f*quantity.to_i
			stockList[stockIndex+1] = stockList[stockIndex+1].to_i-quantity.to_i
			if stockList[stockIndex+1].to_i < 1
				for i in (0...3)
				stockList.delete_at(stockIndex)
				end
			end
			user.stock = stockList.join('|')
			user.save
			return "Success"
		end

	end

	def self.topUsers()
		topList = User.order(:balance)
		output = []

		for i in (1..10)
			if topList[-i] != nil
			output.push(topList[-i].balance.to_f)
			output.push(topList[-i].name)
			end
		end

		return output
	end

end
