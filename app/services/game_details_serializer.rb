class GameDetailsSerializer

    def initialize(game_object)
        @game = game_object
    end

    def to_serialized_json
        options = {
            include: {
                game: {
                    only: [:startTime]
                }
            },
            except: [:created_at, :updated_at],
        }

        @game.to_json(options)
    end
end