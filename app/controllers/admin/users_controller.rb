class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :new, :destroy, :update]
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show


  end

  # GET /users/new
  def new
    @user = User.new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new
    end
    #log_in @user
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit, notice: '管理者ユーザー数は0にはできません'
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
    else
      redirect_to admin_users_path, notice: '管理者ユーザー数は0にはできません'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def admin_user
      redirect_to tasks_path, notice: '管理者権限がありません' unless current_user.admin

    end

end
