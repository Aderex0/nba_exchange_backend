require 'byebug'

class PlayerAverage < ApplicationRecord
    belongs_to :player, optional: true, primary_key: "playerId", foreign_key: "playerId" 

    def self.create_or_update_player_averages
        Player.all.each do |player|
            games_played = player.statistics.length.to_f
            existing_player = PlayerAverage.find_by(playerId: player["playerId"])

            if existing_player
                existing_player.update(
                    points: (player.statistics.sum {|stat| stat.points.to_f} / games_played).round(1),
                    pos: player["pos"],
                    min: (player.statistics.sum {|stat| stat.min.to_f} / games_played).round(1),
                    fgm: (player.statistics.sum {|stat| stat.fgm.to_f} / games_played).round(1),
                    fga: (player.statistics.sum {|stat| stat.fga.to_f} / games_played).round(1),
                    fgp: (player.statistics.sum {|stat| stat.fgp.to_f} / games_played).round(1),
                    ftm: (player.statistics.sum {|stat| stat.ftm.to_f} / games_played).round(1),
                    fta: (player.statistics.sum {|stat| stat.fta.to_f} / games_played).round(1),
                    ftp: (player.statistics.sum {|stat| stat.ftp.to_f} / games_played).round(1),
                    tpm: (player.statistics.sum {|stat| stat.tpm.to_f} / games_played).round(1),
                    tpa: (player.statistics.sum {|stat| stat.tpa.to_f} / games_played).round(1),
                    tpp: (player.statistics.sum {|stat| stat.tpp.to_f} / games_played).round(1),
                    offReb: (player.statistics.sum {|stat| stat.offReb}.to_f / games_played).round(1),
                    defReb: (player.statistics.sum {|stat| stat.defReb}.to_f / games_played).round(1),
                    totReb: (player.statistics.sum {|stat| stat.totReb}.to_f / games_played).round(1),
                    assists: (player.statistics.sum {|stat| stat.assists}.to_f / games_played).round(1),
                    pFouls: (player.statistics.sum {|stat| stat.pFouls}.to_f / games_played).round(1),
                    steals: (player.statistics.sum {|stat| stat.steals}.to_f / games_played).round(1),
                    blocks: (player.statistics.sum {|stat| stat.blocks}.to_f / games_played).round(1),
                    turnovers: (player.statistics.sum {|stat| stat.turnovers}.to_f / games_played).round(1),
                    plusMinus: player.statistics.sum {|stat| stat.plusMinus}
                )
            else     
                PlayerAverage.create(
                    teamId: player["teamId"].to_i,
                    playerId: player["playerId"].to_i,
                    points: (player.statistics.sum {|stat| stat.points.to_f} / games_played).round(1),
                    pos: player["pos"],
                    min: (player.statistics.sum {|stat| stat.min.to_f} / games_played).round(1),
                    fgm: (player.statistics.sum {|stat| stat.fgm.to_f} / games_played).round(1),
                    fga: (player.statistics.sum {|stat| stat.fga.to_f} / games_played).round(1),
                    fgp: (player.statistics.sum {|stat| stat.fgp.to_f} / games_played).round(1),
                    ftm: (player.statistics.sum {|stat| stat.ftm.to_f} / games_played).round(1),
                    fta: (player.statistics.sum {|stat| stat.fta.to_f} / games_played).round(1),
                    ftp: (player.statistics.sum {|stat| stat.ftp.to_f} / games_played).round(1),
                    tpm: (player.statistics.sum {|stat| stat.tpm.to_f} / games_played).round(1),
                    tpa: (player.statistics.sum {|stat| stat.tpa.to_f} / games_played).round(1),
                    tpp: (player.statistics.sum {|stat| stat.tpp.to_f} / games_played).round(1),
                    offReb: (player.statistics.sum {|stat| stat.offReb}.to_f / games_played).round(1),
                    defReb: (player.statistics.sum {|stat| stat.defReb}.to_f / games_played).round(1),
                    totReb: (player.statistics.sum {|stat| stat.totReb}.to_f / games_played).round(1),
                    assists: (player.statistics.sum {|stat| stat.assists}.to_f / games_played).round(1),
                    pFouls: (player.statistics.sum {|stat| stat.pFouls}.to_f / games_played).round(1),
                    steals: (player.statistics.sum {|stat| stat.steals}.to_f / games_played).round(1),
                    blocks: (player.statistics.sum {|stat| stat.blocks}.to_f / games_played).round(1),
                    turnovers: (player.statistics.sum {|stat| stat.turnovers}.to_f / games_played).round(1),
                    plusMinus: player.statistics.sum {|stat| stat.plusMinus}
                )
            end
        end
    end
end