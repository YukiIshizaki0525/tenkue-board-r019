# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :check_guest, only: %i[update destroy]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    if @user.save
      flash[:notice] = "新規登録が完了いたしました。"
      redirect_to new_user_session_path
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
