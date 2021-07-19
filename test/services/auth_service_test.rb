require "test_helper"

class AuthServiceTest < ActiveSupport::TestCase
  test "create" do
    _test_create '',                  '',       'Email can\'t be blank'
    _test_create 'email',             '',       'Email is invalid'
    _test_create 'email@example',     '',       'Password is invalid'
    _test_create 'email@example.com', 'pass',   'Password is invalid'
    _test_create 'email@example.com', '1324567'
  end

  def _test_create(email, password, message=nil)
    user = AuthService.create(email, password)
    if user.is_a? User
      assert_equal nil, user.errors.full_messages.first
      assert user.persisted?
    else
      assert_equal message, user
    end
  end

  test "login" do
    user = users(:one)
    session_token = user.session_token

    _test_login '',                  '',       'Credenciais Invalidas'
    _test_login 'email',             '',       'Credenciais Invalidas'
    _test_login 'email@example',     '',       'Credenciais Invalidas'
    _test_login 'email@example.com', 'pass',   'Credenciais Invalidas'
    _test_login 'one@fixture.com',   '1324567'

    assert_not_equal session_token, user.reload.session_token
  end

  def _test_login(email, password, message=nil)
    user = AuthService.login(email, password)
    if user.is_a? User
      assert_equal nil, user.errors.full_messages.first
      assert user.persisted?
    else
      assert_equal message, user
    end
  end

  test "logout" do
    user = users(:one)
    session_token = user.session_token

    AuthService.logout(nil)
    AuthService.logout(user)

    assert_not_equal session_token, user.reload.session_token
  end
end
