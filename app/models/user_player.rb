class UserPlayer < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :player, optional: true, primary_key: "playerId", foreign_key: "playerId"

    default_scope { order(created_at: :asc) }

    def self.update_bought_player_quantity_and_value(qtyBought, player)
        
        if qtyBought + player.qtyBought - player.qtySold > 1500
            if player.qtyBought.ceil(-2) <= qtyBought + player.qtyBought
                player.update(
                sell: (player.sell + 0.01).round(2),
                buy: (player.buy + 0.03).round(2),
                qtyBought: player.qtyBought + qtyBought
                )
            else
                player.update(
                    qtyBought: player.qtyBought + qtyBought
                )
            end
        elsif qtyBought + player.qtyBought - player.qtySold > 1000
            if player.qtyBought.ceil(-2) <= qtyBought + player.qtyBought
                player.update(
                sell: (player.sell + 0.01).round(2),
                buy: (player.buy + 0.02).round(2),
                qtyBought: player.qtyBought + qtyBought
                )
            else
                player.update(
                    qtyBought: player.qtyBought + qtyBought
                )
            end
        else
            if player.qtyBought.ceil(-2) <= qtyBought + player.qtyBought
                player.update(
                sell: (player.sell + 0.01).round(2),
                buy: (player.buy + 0.01).round(2),
                qtyBought: player.qtyBought + qtyBought
                )
            else
                player.update(
                    qtyBought: player.qtyBought + qtyBought
                )
            end
        end
    end

    def self.update_sold_player_quantity_and_value(qtySold, player)

        if player.qtyBought - qtySold + player.qtySold > 1500
            if (player.qtySold+1).ceil(-2) <= qtySold + player.qtySold
                player.update(
                sell: (player.sell - 0.01).round(2),
                buy: (player.buy - 0.03).round(2),
                qtySold: player.qtySold + qtySold
                )
            else
                player.update(
                    qtySold: player.qtySold + qtySold
                )
            end
        elsif player.qtyBought - qtySold + player.qtySold > 1000
            if (player.qtySold+1).ceil(-2) <= qtySold + player.qtySold
                player.update(
                sell: (player.sell - 0.01).round(2),
                buy: (player.buy - 0.02).round(2),
                qtySold: player.qtySold + qtySold
                )
            else
                player.update(
                    qtySold: player.qtySold + qtySold
                )
            end
        else
            if (player.qtySold+1).ceil(-2) <= qtySold + player.qtySold
                player.update(
                sell: (player.sell - 0.01).round(2),
                buy: (player.buy - 0.01).round(2),
                qtySold: player.qtySold + qtySold
                )
            else
                player.update(
                    qtySold: player.qtySold + qtySold
                )
            end
        end
    end

end
