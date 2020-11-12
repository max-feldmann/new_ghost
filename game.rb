require_relative ('round.rb')
require_relative ('player.rb')

class Game

    attr_accessor :players

    def initialize
        @players = []
        add_players

        @losses = Hash.new{0}
        
        @word = "GHOST"
    end

    def play_a_round

        until @losses.any? {|player, losses| losses == 5}
            system ("clear")
            puts "Standings:"
            display_standings
            puts
            puts "Welcome to a new round of Ghost!"
            puts
           
            this_round = Round_of_Ghost.new(@players)     #  (@player_1, @player_2)
            loser = this_round.play_round
            @losses[loser] += 1

            is_someone_the_ghost
        end

        puts "The game has ended"
    end

    def add_players
        
        puts "How many Players are you?"
        puts
        number_of_players = gets.chomp.to_i

        i = 0
        while i < number_of_players
            puts "Hey player #{i + 1}! What is your name?"
            @players << Player.new(gets.chomp)
            i += 1
        end
    end

    private

    def is_someone_the_ghost
        @losses.each do |player, losses|
            if losses == 5
                puts "#{player.player_name} is the Ghost!"
                puts
                puts "Final Standings were:"
                display_standings
                return true
            end
        end
        false
    end

    def display_standings
        @losses.each_pair do |player, losses|
            puts "#{player.player_name} --> '#{@word[0...losses]}''"
        end
    end
end

G = Game.new.play_a_round