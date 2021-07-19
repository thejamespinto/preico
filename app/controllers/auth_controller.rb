class AuthController < ApplicationController

  # GET /auth
  def index
  end

  # POST /auth/create
  def create
    user = AuthService.create(params[:email], params[:password])
    if user.is_a? User
      set_current_user_to(user)
      redirect_to home_path, notice: 'Cadastrado com sucesso'
    else
      @error = user
      render :index
    end
  end

  # POST /auth/login
  def login
    user = AuthService.login(params[:email], params[:password])
    if user.is_a? User
      set_current_user_to user
      redirect_to home_path, notice: 'Logado com sucesso'
    else
      @error = user
      render :index
    end
  end

  # POST /auth/logout
  def logout
    AuthService.logout(current_user)
    unset_current_user
    redirect_to auth_path, notice: 'Logout com sucesso'
  end
end
