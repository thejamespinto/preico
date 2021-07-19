class UserWallet < ApplicationRecord
  KEYS = %w[BTC ETH BCH XLM WDGLD ALGO USD-D USDT]

  belongs_to :user

  validates_presence_of :key
  validates_inclusion_of :key, in: KEYS

  has_many :entries, class_name: 'UserWalletEntry'
end
