class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/
  PASS_REGEXP = /\S{6,64}/

  validates_presence_of :email
  validates_format_of :email, with: EMAIL_REGEXP
  validates_uniqueness_of :email, on: :create

  validates_format_of :password, with: PASS_REGEXP

  def password?(v)
    BCrypt::Password.new(password_hash) == BCrypt::Password.create(v)
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(v)
    @password = v
    self.password_hash = BCrypt::Password.create(v)
  end

  def session_token!
    update! session_token: SecureRandom.uuid
  end

  def admin?
    role == 'admin'
  end

  def admin!
    update! role: 'admin'
  end
end
