json.array!(@stocks) do |stock|
  json.extract! stock, :id, :title, :description, :image_url, :price
  json.url stock_url(stock, format: :json)
end
