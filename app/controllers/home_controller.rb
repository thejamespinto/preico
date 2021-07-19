require 'net/http'

class HomeController < ApplicationController
  user!

  # GET /home
  def index
    @wallets = WalletService.for(current_user)

    key = 'BTC'
    @address = params[:address].presence || '3BTgHrKiLNix4kM72Q8aHY2ws1X8pmmqv5'

    @transactions = WalletService.fetch_transactions(key, @address)
  end

  # POST /home/sim_funds
  def sim_funds
    user = current_user
    key = params[:key]
    amount = params[:amount].to_i

    wallet = user.wallets.where(key: key).first
    wallet.entries.create! amount: amount
    wallet.amount += amount
    wallet.save!

    redirect_to :home, notice: 'Simulado com sucesso'
  end

  # POST /home/sim_address
  def sim_address
    redirect_to home_path(address: params[:address]), notice: 'em teste'
  end

end
