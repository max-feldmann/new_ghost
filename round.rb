require 'set'
require_relative ('player.rb')

class Round_of_Ghost

    attr_reader :fragment, :dictionary, :player1, :player2, :current_player

    def initialize(players)
        
        @players = players
        @lifes = Hash.new(0)
        @current_player = nil
        
        randomise_start
        
        @fragment = ""
        @dictionary = create_dictionary
    end

    def play_round
        @players.each{|player| player.reset_player}
        loser = nil

        until loser
            take_turn(@current_player)

            if you_lost_a_life_and_are_dead(@current_player)
                loser = @current_player
                puts
                puts "You have lost this round, because you made too many invalid plays, dude!"
                break
            end
            
            if we_got_a_loser(fragment)
                loser = @current_player
                puts
                puts "'#{@fragment}' was a complete word from the dictionary!"
            end

            next_player
            puts "The current Fragment is #{@fragment}"
        end

    end_round(loser)
    end

    def you_lost_a_life_and_are_dead(player)
        if @current_player.lifes == 0
            return true
        end
            
        false
    end

    def end_round(loser)
        puts
        puts "End round and start next? [y]"
        answer = gets.chomp

        if answer == "y" || answer.empty?
            return loser
        else
            system ("clear")
            end_round(loser)
        end
    end

    def take_turn(player)
        puts "It is  #{player.player_name}'s turn! Add your Letter to the Fragment! (#{@current_player.lifes} lifes left)"
        puts
        letter = nil

        until letter
            letter = gets.chomp.downcase

            if !valid_play?(letter)
                @current_player.take_a_life

                puts "This wasn´t a valid play!"
                puts "You have #{@current_player.lifes} lifes left!" 
                    return if @current_player.lifes == 0
                puts "Try again. Hint: The current Fragment is #{@fragment}"
                puts
                letter = nil
            end
        end

        add_letter(letter)
    end

    private
    
    def valid_play?(letter)

        potential_fragment = @fragment + letter

        return false if letter.empty?
        return false if letter.length > 1

        if !is_word_fragment?(potential_fragment)
            return false
        end
        true
    end

    def add_letter(letter)
        @fragment << letter
    end

    def we_got_a_loser(string)
        @dictionary.any? {|word| word == string.downcase}
    end

    def is_word_fragment?(string)
        @dictionary.any? {|word| word.start_with?(string)}
    end

    def next_player
        current_index = @players.find_index(@current_player)
        @current_player = @players[(current_index + 1) % @players.length]
    end

    def create_dictionary 
        data = File.readlines("dictionary.txt").map(&:chomp)
        dictionary = Set.new(data)
        return dictionary
    end

    def randomise_start
        @current_player = @players[rand(0..@players.length - 1)]
    end
end