module AuthService
  module_function

  def create(email, password)
    user = User.create(email: email, password: password)

    return user.errors.full_messages.first unless user.persisted?

    user.session_token!
    user
  end

  def login(email, password)
    user = User.find_by(email: email)

    return 'Credenciais Invalidas' if user.nil? || user.password?(password)

    user.session_token!
    user
  end

  def logout(user)
    user&.session_token!
    true
  end

end
