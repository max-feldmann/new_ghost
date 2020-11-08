require 'set'

class Round_of_Ghost

    attr_reader :fragment, :dictionary, :player1, :player2, :current_player

    def initialize(player1, player2, losses)
        
        @player1 = player1
        @player2 = player2
        @losses = losses

        @current_player = randomise_start
        
        @fragment = ""
        @dictionary = create_dictionary
    end

    def play_round
        loser = nil

        until loser
            take_turn(@current_player)

            if we_got_a_loser(fragment)
                loser = @current_player
            end
            next_player
            puts "The current Fragment is #{@fragment}"
        end

        if is_someone_the_ghost
            puts "The game has handed! Bye bye!"
        else
            end_round(loser)
        end
    end

    def end_round(loser)
        puts
        puts "You have lost this round!"
        puts
        puts "Start the next round? [y]"
        answer = gets.chomp

        if answer == "y"
            return loser
        else
            end_round
        end

    end

    def take_turn(player)
        puts "It is  #{player}'s turn! Add your Letter to the Fragment!"
        puts
        letter = nil

        until letter
            letter = gets.chomp.downcase

            unless valid_play?(letter)
                puts "This wasn´t a valid play :( Try again. Hint: The current Fragment is #{@fragment}"
                puts
                letter = nil
            end
        end

        add_letter(letter)
    end

    private

    def is_someone_the_ghost
        @losses.each do |player, losses|
            if losses == 2
                puts "#{player} is the friggin ghost!"
                return true
            end
        end
        false
    end
    
    def valid_play?(letter)
        return false if letter.empty?
        return false if letter.length > 1

        potential_fragment = @fragment + letter

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
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
    end

    def create_dictionary 
        data = File.readlines("dictionary.txt").map(&:chomp)
        dictionary = Set.new(data)
        return dictionary
    end

    def randomise_start
        random = rand(1..2)
        if random == 1
            @current_player = @player1
        else
            @current_player = @player2
        end
    end
end