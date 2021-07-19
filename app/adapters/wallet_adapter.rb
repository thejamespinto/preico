module WalletAdapter
  module_function

  def get(key, address)
    get_btc(address)
  end

  def get_btc(address)
    uri = URI("https://blockchain.info/rawaddr/#{address}?limit=10")
    res = Net::HTTP.get_response(uri)
    JSON(res.body)
  end

  def get_btc_default
    JSON(File.read('app/adapters/wallet_adapter_get.body.json'))
  end

end
