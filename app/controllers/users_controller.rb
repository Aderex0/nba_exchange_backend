class UsersController < ApplicationController
    wrap_parameters :user, include: [:username, :password, :account_balance, :firstName, :lastName, :dob, :email]

    def create
      byebug
      new_user = User.new(user_params)
      if new_user.save
          render json: new_user
      else
          render json: @Trend.errors, status: :unprocessable_entity
      end
    end

    def login
        @user = User.find_by(username: params[:username])
        if @user and @user.authenticate(params[:password])
          render json: { username: @user.username, id: @user.id, account_balance: @user.account_balance, token: issue_token({ id: @user.id })}
        else
          render json: { error: 'Username/password combination invalid' }, status: 401
        end
      end
    
      def validate
        @user = get_current_user
        if @user
          render json: { username: @user.username, id: @user.id, account_balance: @user.account_balance, token: issue_token({ id: @user.id })}
        else
          render json: { error: 'Unable to validate user.' }, status: 401
        end
      end

    private

    def user_params
        params.require(:user).permit(:username, :password, :account_balance, :firstName, :lastName, :dob, :email)
    end
      
end