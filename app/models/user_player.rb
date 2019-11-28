class UserPlayer < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :player, optional: true, primary_key: "playerId", foreign_key: "playerId"

    default_scope { order(created_at: :asc) }

    def self.update_bought_player_quantity_and_value(qtyBought, player)
        if player.qtyBought.ceil(-2) <= qtyBought + player.qtyBought
            player.update(
              sell: player.sell + 0.01,
              buy: player.buy + 0.01,
              qtyBought: player.qtyBought + qtyBought
            )
        else
            player.update(
                qtyBought: player.qtyBought + qtyBought
            )
        end
    end

    def self.update_sold_player_quantity_and_value(qtySold, player)
        if player.qtySold.ceil(-2) <= qtySold + player.qtySold
            player.update(
              sell: player.sell - 0.01,
              buy: player.buy - 0.01,
              qtySold: player.qtySold + qtySold
            )
        else
            player.update(
                qtySold: player.qtySold + qtySold
            )
        end
    end


end
