class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_minimum_password_length, only: %i[new edit create update]

  # GET /users or /users.json
  def index
    @users = User.order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "ユーザーを登録しました。" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(filtered_user_params)
        format.html { redirect_to users_path, notice: "ユーザー情報を更新しました。", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "ユーザーを削除しました。", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    def user_params
      params.expect(user: %i[email password password_confirmation])
    end

    def filtered_user_params
      sanitized = user_params
      return sanitized if sanitized[:password].present?

      sanitized.except(:password, :password_confirmation)
    end

    def set_minimum_password_length
      @minimum_password_length = User.password_length.min
    end
end
