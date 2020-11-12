class Player

    attr_reader :player_name 
    attr_accessor :lifes
    
    def initialize(name)
        @player_name = name
        @lifes = 3
    end

    def take_a_life
        @lifes -= 1
    end

    def reset_player
        @lifes = 3
    end
end

# playa = Player.new("Tom")
# p playa
# playa.take_a_life
# p playa