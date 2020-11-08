require_relative ('round.rb')

class Game


    def initialize

        @player_1 = nil
        @player_2 = nil
        @losses = Hash.new{0}

        @word = "GHOST"
        
    end

    def play_a_round

        add_players

        until @losses.any? {|player, losses| losses == 2}
            system ("clear")
            display_standings
            puts
            puts "Welcome to a new round of Ghost!"
            puts
           
            this_round = Round_of_Ghost.new(@player_1, @player_2, @losses)
            loser = this_round.play_round
            @losses[loser] += 1
        end
    end

    private

    def display_standings
        puts "Standings:"
        @losses.each_pair do |player, losses|
            puts player
            p @word[0...losses]
        end
    end

    def add_players
        
        puts "Hey Player 1! Enter your Name!"
        @player_1 = gets.chomp

        puts "Hey Player 2! Enter your Name!"
        @player_2 = gets.chomp
    end
end

G = Game.new.play_a_round