class Stock < ActiveRecord::Base
	validates :title, :description, :image_url, :price, presence: true
	validates :title, uniqueness: true

	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	
	def self.stocksPopular
		@stocks = ['bkw','a', 'aa', 'aapl', 'abbv', 'abc', 'abt', 'ace', 'aci', 'acn', 'act', 'adbe', 'adi', 'adm', 'adp', 'adsk', 'adt', 'aee', 'aeo', 'aep', 'aes', 'aet', 'afl', 'agn', 'aig', 'aiv', 'aiz', 'akam', 'all', 'altr', 'alxn', 'amat', 'amd', 'amgn', 'amp', 'amt', 'amzn', 'an', 'anf', 'ann', 'aon', 'apa', 'apc', 'apd', 'aph', 'apol', 'arg', 'arna', 'aro', 'ati', 'atvi', 'avb', 'avp', 'avy', 'axp', 'azo', 'ba', 'bac', 'bax', 'bbby', 'bbry', 'bbt', 'bby', 'bcr', 'bdx', 'beam', 'ben', 'bf-b', 'bhi', 'big', 'biib', 'bk', 'bks', 'blk', 'bll', 'bmc', 'bms', 'bmy', 'brcm', 'brk-b', 'bsx', 'btu', 'bwa', 'bxp', 'c', 'ca', 'cab', 'cag', 'cah', 'cam', 'cat', 'cb', 'cbg', 'cbs', 'cce', 'cci', 'ccl', 'celg', 'cern', 'cf', 'cfn', 'chk', 'chrw', 'ci', 'cim', 'cinf', 'cl', 'clf', 'clx', 'cma', 'cmcsa', 'cme', 'cmg', 'cmi', 'cms', 'cnp', 'cnx', 'cof', 'cog', 'coh', 'col', 'cop', 'cost', 'cov', 'cpb', 'crm', 'csc', 'csco', 'csx', 'ctas', 'ctl', 'ctsh', 'ctxs', 'cvc', 'cvs', 'cvx', 'd', 'dal', 'dd', 'dds', 'de', 'dell', 'df', 'dfs', 'dg', 'dgx', 'dhi', 'dhr', 'dis', 'disca', 'dks', 'dlph', 'dltr', 'dlx', 'dnb', 'dnr', 'do', 'dov', 'dow', 'dps', 'dri', 'dsw', 'dte', 'dtv', 'duk', 'dva', 'dvn', 'ea', 'ebay', 'ecl', 'ed', 'efx', 'eix', 'el', 'emc', 'emn', 'emr', 'eog', 'eqr', 'eqt', 'esrx', 'esv', 'etfc', 'etn', 'etr', 'ew', 'exc', 'expd', 'expe', 'expr', 'f', 'fast', 'fb', 'fcx', 'fdo', 'fdx', 'fe', 'ffiv', 'fhn', 'fis', 'fisv', 'fitb', 'fl', 'flir', 'flr', 'fls', 'flws', 'fmc', 'fosl', 'frx', 'fslr', 'fti', 'ftr', 'gas', 'gci', 'gd', 'ge', 'ges', 'gild', 'gis', 'glw', 'gm', 'gmcr', 'gme', 'gnw', 'goog', 'gpc', 'gps', 'grmn', 'grpn', 'gs', 'gt', 'gww', 'hal', 'har', 'has', 'hban', 'hcbk', 'hcn', 'hcp', 'hd', 'hes', 'hig', 'hog', 'hon', 'hot', 'hov', 'hp', 'hpq', 'hrb', 'hrl', 'hrs', 'hsp', 'hst', 'hsy', 'hum', 'ibm', 'ice', 'iff', 'igt', 'intc', 'intu', 'ip', 'ipg', 'ir', 'irm', 'isrg', 'itw', 'ivz', 'jbl', 'jci', 'jcp', 'jdsu', 'jec', 'jnj', 'jnpr', 'josb', 'joy', 'jpm', 'jwn', 'k', 'key', 'kim', 'klac', 'kmb', 'kmi', 'kmx', 'ko', 'kr', 'krft', 'kss', 'ksu', 'l', 'leg', 'len', 'lh', 'life', 'lll', 'lltc', 'lly', 'lm', 'lmt', 'lnc', 'lo', 'low', 'lrcx', 'lsi', 'ltd', 'luk', 'luv', 'lyb', 'm', 'ma', 'mac', 'mar', 'mas', 'mat', 'mcd', 'mchp', 'mck', 'mco', 'mcp', 'mdlz', 'mdt', 'met', 'mgm', 'mhfi', 'mjn', 'mkc', 'mmc', 'mmm', 'mnst', 'mo', 'molx', 'mon', 'mos', 'mpc', 'mrk', 'mro', 'ms', 'msft', 'msi', 'mtb', 'mu', 'mur', 'mwv', 'myl', 'nbl', 'nbr', 'ndaq', 'ne', 'nee', 'nem', 'nflx', 'nfx', 'ni', 'nile', 'nke', 'nly', 'noc', 'nok', 'nov', 'nrg', 'nsc', 'ntap', 'ntri', 'ntrs', 'nu', 'nue', 'nvda', 'nwl', 'nwsa', 'nyx', 'oi', 'oke', 'omc', 'orcl', 'orly', 'oxy', 'p', 'payx', 'pbct', 'pbi', 'pcar', 'pcg', 'pcl', 'pcln', 'pcp', 'pdco', 'peg', 'pep', 'petm', 'pets', 'pfe', 'pfg', 'pg', 'pgr', 'ph', 'phm', 'pki', 'pld', 'pll', 'pm', 'pnc', 'pnr', 'pnw', 'pom', 'ppg', 'ppl', 'prgo', 'pru', 'psa', 'psx', 'pwr', 'px', 'pxd', 'qcom', 'qep', 'r', 'rai', 'rdc', 'rf', 'rhi', 'rht', 'rl', 'rok', 'rop', 'rost', 'rrc', 'rsg', 'rsh', 'rtn', 's', 'sai', 'sbux', 'scg', 'schl', 'schw', 'sd', 'se', 'see', 'sfly', 'shld', 'shw', 'sial', 'siri', 'sjm', 'sks', 'slb', 'slm', 'sna', 'sndk', 'sne', 'sni', 'so', 'spg', 'spls', 'srcl', 'sre', 'sti', 'stj', 'stt', 'stx', 'stz', 'swk', 'swn', 'swy', 'syk', 'symc', 'syy', 't', 'tap', 'tdc', 'te', 'teg', 'tel', 'ter', 'tgt', 'thc', 'tibx', 'tif', 'tjx', 'tm', 'tmk', 'tmo', 'trip', 'trow', 'trv', 'tsla', 'tsn', 'tso', 'tss', 'twc', 'twx', 'txn', 'txt', 'tyc', 'ua', 'unh', 'unm', 'unp', 'ups', 'urbn', 'usb', 'utx', 'v', 'vale', 'var', 'vfc', 'viab', 'vitc', 'vlo', 'vmc', 'vno', 'vprt', 'vrsn', 'vtr', 'vz', 'wag', 'wat', 'wdc', 'wec', 'wfc', 'wfm', 'whr', 'win', 'wlp', 'wm', 'wmb', 'wmt', 'wpo', 'wpx', 'wtw', 'wu', 'wy', 'wyn', 'wynn', 'x', 'xel', 'xl', 'xlnx', 'xom', 'xray', 'xrx', 'xyl', 'yhoo', 'yum', 'zion', 'zlc', 'zmh', 'znga', 'camp', 'cldx', 'ecyt', 'gtn', 'htz', 'nus', 'pvtb', 'qdel', 'snts', 'wgo', 'wwww'].sort
		@stocks.map!(&:upcase)
	end

	def self.stockCount(list)
		counter = 0
		for i in (1...list.length).step(3)
			counter += list[i].to_i
		end
		return counter
	end

	def self.convertHash(list)
		hashStock = Hash.new
		for i in (0...list.length).step(3)
			hashStock[list[i]] = list[i+1]
		end
		return hashStock
	end

	def self.sumStocks(list,list2)
		sumStocks = []
		sum = 0
		for i in (0...list.length).step(3)
			sumStocks.push(list[i+1].to_f*list2[i+1].to_f)
			sum += list[i+1].to_f*list2[i+1].to_f
		end
		sumStocks.push(sum)
		return sumStocks
	end

	def self.news()
		require 'open-uri'
		links = []
		doc = Nokogiri::HTML(open("http://www.reddit.com/r/StockMarket"))
		headlines = doc.css("div.thing").css('a.title')
		images = doc.css("div.thing").css('a.thumbnail')
		for i in (0..5)
			if images.map { |link| link['href'] }[i][1] != 'r'
				links.push(headlines[i].text)
				links.push(images[i])
			end
		end
		return links
	end

	def self.stockHistory(list,balance,term)
		stocks = []
		for i in (0...list.length).step(3)
			stocks.push(StockQuote::Stock.history(list[i], DateTime.now-term.days, DateTime.now))
			for t in (0...stocks[i/3].length)
				stocks[i/3][t].close = stocks[i/3][t].close.to_f * list[i+1].to_f
			end
		end

		sum = Hash.new(0)


		for q in (0...stocks.length)
			for w in (0...stocks[q].length)
				sum[stocks[q][w].date] += sprintf("%.2f",stocks[q][w].close.to_f).to_f
				sum[stocks[q][w].date] = sprintf("%.2f",sum[stocks[q][w].date]).to_f
			end
		end

		sum[DateTime.now] = balance


		return sum
	end

	def self.data(name)
		sum = Hash.new(0)
		data = YahooFinance.historical_quotes(name, Time::now-7.days, Time::now, { raw: false, period: :daily })
		for i in (0...data.length)
			sum[DateTime.strptime(data[i][:trade_date],"%Y-%m-%d")] = data[i][:close]
		end
		return sum
	end

	def self.info(name)
		output = []
		output.push(StockQuote::Stock.quote(name, nil, nil, ['Symbol', 'Ask', 'Bid', 'Name','Open','DaysHigh','DaysLow','MarketCapitalization','LastTradeDate','LastTradePriceOnly','PercentChangeFromTwoHundreddayMovingAverage','PercentChangeFromFiftydayMovingAverage']))
		if output[0].percent_change_from_fiftyday_moving_average[0] != "+"
			output.push("down")
		else
			output.push("up")
		end
		if output[0].percent_change_from_two_hundredday_moving_average[0] != "+"
			output.push("down")
		else
			output.push("up")
		end
	end
end
