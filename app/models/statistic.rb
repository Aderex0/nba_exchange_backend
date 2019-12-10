require 'unirest'
require 'byebug'

class Statistic < ApplicationRecord
    belongs_to :game, optional: true
    belongs_to :player, optional: true

    #TO BE RAN ON DAILY BASIS AFTER THE GAME API HAS BEEN CALLED. Updates game stats.
    def self.fetch_finished_game_stats

        self.finished_games.each do |game|
            gameId = game["gameId"]

            response = Unirest.get "https://api-nba-v1.p.rapidapi.com/statistics/players/gameId/" + "#{gameId}",
                headers: {
                    "X-RapidAPI-Host" => "key",
                    "X-RapidAPI-Key" => "key"
                }

            self.create_and_save_statistics(response)
        end
    end


    def self.create_and_save_statistics(response)
        
        response.body["api"]["statistics"].each do |statistic|
            player_stats = Statistic.new(
                gameId: statistic["gameId"].to_i,
                teamId: statistic["teamId"].to_i,
                playerId: statistic["playerId"].to_i,
                points: statistic["points"].to_i,
                pos: statistic["pos"],
                min: statistic["min"].to_f,
                fgm: statistic["fgm"].to_i,
                fga: statistic["fga"].to_i,
                fgp: statistic["fgp"].to_f,
                ftm: statistic["ftm"].to_i,
                fta: statistic["fta"].to_i,
                ftp: statistic["ftp"].to_f,
                tpm: statistic["tpm"].to_i,
                tpa: statistic["tpa"].to_i,
                tpp: statistic["tpp"].to_f,
                offReb: statistic["offReb"].to_i,
                defReb: statistic["defReb"].to_i,
                totReb: statistic["totReb"].to_i,
                assists: statistic["assists"].to_i,
                pFouls: statistic["pFouls"].to_i,
                steals: statistic["steals"].to_i,
                blocks: statistic["blocks"].to_i,
                turnovers: statistic["turnovers"].to_i,
                plusMinus: statistic["plusMinus"].to_i
            )

            player = Player.find_by(playerId: player_stats.playerId)
            users = UserPlayer.where(playerId: player_stats.playerId)
            uniq_users = users.uniq {|all_users| all_users.user}

            if player
                if player_stats.points <= (player.player_average.points * 0.5 )
                    player.update(buy: (player.buy - 0.01).round(2), sell: (player.sell - 0.01).round(2))
                elsif player_stats.points <= player.player_average.points
                    if uniq_users
                        uniq_users.each do |user|
                            found_user = User.find_by(id: user.user_id)
                            found_user.update(
                                account_balance: (found_user.account_balance + 0.01).round(2)
                            )
                        end
                    end
                elsif player_stats.points <= ((player.player_average.points * 0.5) + player.player_average.points)
                    if uniq_users
                        uniq_users.each do |user| 
                            found_user = User.find_by(id: user.user_id)
                            found_user.update(
                                account_balance: (found_user.account_balance + 0.02).round(2)
                            )
                        end
                    end
                else
                    if uniq_users
                        uniq_users.each do |user| 
                            found_user = User.find_by(id: user.user_id)
                            found_user.update(
                                account_balance: (found_user.account_balance + 0.03).round(2)
                            )
                        end
                    end
                    player.update(buy: (player.buy + 0.01).round(2), sell: (player.sell + 0.01).round(2))
                end 

                player_stats.save
            end
        end
    end

    #Helper: Checks if game if finished but has no statistics
    def self.finished_games
        finished_games = []

        Game.all.each do |game|
            if game.statistics === [] && game["statusShortGame"] === 3
                finished_games.push(game)
            end
        end
        finished_games
    end
end

found_user.update(account_balance: account_balance + 0.01)
