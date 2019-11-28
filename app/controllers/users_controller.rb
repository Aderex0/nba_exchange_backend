class UsersController < ApplicationController

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
      
end