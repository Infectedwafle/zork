require "./models/neighborhood";
require "./models/player";
require "./models/command";

class Game
	def initialize()
		@player = nil;
		@neighborhood = Neighborhood.new(9);
	end

	def options()

	end

	def start()
		puts "Welcome to ZORK!";
		puts "Your neighborhood has been overrun with monsters";
		puts "You have been tasked with clearing the area of all monsters in the area";
		system('cls');
		puts "What is your name?";
		name = gets.chomp;
		@player = Player.new(name);
		system('cls');
		puts "#{@player.name} you are standing in front of your house at the center of your neighborhood";
	end

	def runLoop()
		gameWon = false
		neighborhoodCommands = Command.new(nil);
		houseCommands = Command.new("house");
		house = nil; 
		
		while(!gameWon)
			if(house == nil)
				home = neighborhoodLoop(neighborhoodCommands, home);
			else
				homeLoop(houseCommands);
			end
		end
	end

	def neighborhoodLoop(command, home)
		case command.getCommand()
		when 'left'
			if(@player.location % 3 != 1)
				@player.location = @player.location - 1;
				puts "You have moved west to another house."
			else
				puts "You are at the edge of your neighborhood and cannot go further west."
			end
		when 'right'
			if(@player.location % 3 != 0)
				@player.location = @player.location + 1;
				puts "You have moved east to another house."
			else
				puts "You are at the edge of your neighborhood and cannot go further east."
			end
		when 'up'
			if(@player.location + 3 < 10)
				@player.location = @player.location + 3;
				puts "You have moved north to another house."
			else
				puts "You are at the edge of your neighborhood and cannot go further north."
			end
		when 'down'
			if(@player.location - 3 > 0)
				@player.location = @player.location - 3;
				puts "You have moved north to another house."
			else
				puts "You are at the edge of your neighborhood and cannot go further south."
			end
		when 'si'
			puts "Weapon Name\t-\tUses"
			@player.inventory.each do |weapon|
				if(weapon.uses < 0)
					puts "#{weapon.name}\t-\tInfinity";
				else
					puts "#{weapon.name}\t-\t#{weapon.uses}";
				end
			end
		when 'sm'
			# print map of houses and monster count info
		when 'eh'
			home = @neighborhood.homes[@player.location - 1]
			puts "You entered house number #{@player.location}"
		else
			puts "That is not a command.";
		end
		
		return home
	end

	def homeLoop(command, home)
		puts "Enter House";
		case command.getCommand()
		when 'left'
			puts 'You are moving left';
		else
			puts "That is not a command.";
		end
	end
end