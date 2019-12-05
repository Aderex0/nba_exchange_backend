class UserPlayersController < ApplicationController

    def buy_player
        player = Player.find_by(playerId: params[:playerId])
        UserPlayer.update_bought_player_quantity_and_value(params[:qty].to_i, player)
    
        user = User.find(params[:user_id])
        user.update(
          account_balance: (user.account_balance - (params[:price] * params[:qty].to_i).round(2)).round(2)
        )
    
        UserPlayer.create(
          user_id: user.id,
          playerId: player.playerId,
          qtyOwned: params[:qty].to_i,
          boughtPrice: params[:price]
        )

        render json: { qtyOwned: params[:qty].to_i, boughtPrice: params[:price], firstName: player.firstName, lastName: player.lastName, account_balance: user.account_balance.round(2) }
      end

      def sell_player
        player = Player.find_by(playerId: params[:playerId])
        UserPlayer.update_sold_player_quantity_and_value(params[:qty].to_i, player)
    
        user = User.find(params[:user_id])
        user.update(
          account_balance: (user.account_balance + (params[:price] * params[:qty].to_i).round(2)).round(2)
        )

        owned_player = UserPlayer.find(params[:transaction_id])
        if owned_player.qtyOwned === params[:qty].to_i
          owned_player.delete
        else
          owned_player.update(
            qtyOwned: owned_player.qtyOwned - params[:qty].to_i
          )
        end

        render json: user
      end

      def get_owned_players
        user_players = UserPlayer.where(user_id: request.headers["user"].to_i)

        render json: UserPlayerSerializer.new(user_players).to_serialized_json
      end

end