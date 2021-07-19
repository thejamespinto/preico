module WalletService
  module_function

  def for(user)
    UserWallet::KEYS.map do |key|
      user.wallets.where(key: key).first_or_create!
    end
  end

  def fetch_transactions(key, address)
    ret = []
    blockchain =  Rails.cache.fetch("blockchain-#{key}-#{address}", expires_in: 1.hours) do
                    WalletAdapter.get(key, address)
                  end
    # blockchain = WalletAdapter.get(key, address)
    # blockchain = WalletAdapter.get_btc_default

    if blockchain['txs']
      blockchain['txs'].each do |tx|
        tx['out'].each do |tx_out|
          item = tx.slice('hash', 'weight', 'fee', 'result', 'balance')
          item['out'] = tx_out['addr']
          ret << item
        end
      end
    else
      ret << blockchain
    end

    ret
  end

end
