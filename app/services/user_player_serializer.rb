class UserPlayerSerializer

    def initialize(player_object)
        @player = player_object
    end

    def to_serialized_json
        options = {
            include: {
                player: {
                    except: [:created_at, :updated_at, :per]
                }
            },
            except: [:created_at, :updated_at],
        }

        @player.to_json(options)
    end
end