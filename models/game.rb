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

	# Starts the game and gets the players name
	def start()
		puts "Welcome to ZORK!";
		puts "Your neighborhood has been overrun with monsters.";
		puts "You have been tasked with clearing the area of all monsters.";
		
		puts "\n\nWhat is your name?";
		name = gets.chomp;
		@player = Player.new(name);
		system('cls');
		puts "#{@player.name} you are standing in front of your house at the center of your neighborhood";
	end

	# A loop that runs until the neighborhood is saved or the player dies
	def runLoop()
		gameWon = false;

		# Setup the command for when in a house and when in the neighborhood
		neighborhoodCommands = Command.new(nil);
		houseCommands = Command.new("house");
		home = nil; 
		
		# Game Loop until Player dies or game is won
		while(!gameWon)
			# Check to see if is in a home or not
			if(home === nil)
				home = neighborhoodLoop(neighborhoodCommands, home);
			else
				homeLoop(houseCommands, home);
				home = nil;
			end

			# Check for player death
			if(@player.health == 0)
				puts "You have died and failed everyone in your neighborhood.  Too Bad!";
				return nil;
			end

			# Check if neighborhood is clear
			if(@neighborhood.all_clear())
				gameWon = true;
			end
		end

		puts "You have saved the neighborhood!!!"
	end

	# the neighborhood Loop it controls moving around the neighboorhood and entering houses
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
				puts "You have moved south to another house."
			else
				puts "You are at the edge of your neighborhood and cannot go further south."
			end
		when 'si'
			puts "Weapon Name\t-\tUses"
			@player.inventory.each do |weapon|
				if(weapon.uses < 0)
					puts "#{weapon.name}\t-\tUnlimited uses";
				else
					puts "#{weapon.name}\t-\t#{weapon.uses} uses";
				end
			end
		when 'sm'
			puts "You lost the map and connot use it anymore";
			# print map of houses and monster count info
			# TODO: print map of neighborhood
		when 'eh'
			puts "You entered house number #{@player.location}";
			home = @neighborhood.homes[@player.location - 1];
		when 'ns'
			@neighborhood.stats();
		else
			puts "That is not a command.";
		end
		
		return home
	end

	# Runs a loop wile in the home
	def homeLoop(commands, home)
		while(true) #wait for commands until house exited
			case commands.getCommand()
			
			when 'am'
				attackLoop(home)

				if(@player.health == 0)
					return nil;
				end
			when 'hs'
				# Show staus of house here
				home.getStatus();
			when 'eh'
				# exit the house
				puts puts "You exited house number #{@player.location}"
				return nil;
			else
				puts "That is not a command.";
			end
		end
	end

	# Runs the loop for attacking monsters in the house
	def attackLoop(home)
		attacking = true;
		
		while attacking
			puts "Choose a weapon";
			for i in 1..@player.inventory.length do
				if(@player.inventory[i-1].uses < 0)
					puts "#{i} - #{@player.inventory[i-1].name} Unlimited uses"
				else
					puts "#{i} - #{@player.inventory[i-1].name} #{@player.inventory[i-1].uses} uses"
				end
			end

			weaponNumber = gets.chomp.to_i;
			weapon = @player.inventory[weaponNumber - 1];

			# Player Attacks
			home.monsters.each do |monster|
				if(monster.type != "person")
					damage = @player.attack * weapon.attack_modifier;
					monster.takeDamage(damage, home);
					puts "You damaged #{monster.type} with #{weapon.name} for #{damage}";
				end
			end
			puts "\n";

			# Monsters Attack
			home.monsters.each do |monster|
				@player.takeDamage(monster.attack);
				if(monster.type == "person")
					puts "#{monster.type} gives you candy healing 1 Health Point";
				else
					puts "#{monster.type} hit you for #{monster.attack}";
				end

				if(@player.health == 0)
					return nil;
				end
			end

			wait = gets.chomp; # wait so user can read screen before showing monster and player stats
			system("clear");
			home.monsterStats();
			puts "\n";
			@player.stats();
			wait = gets.chomp; # wait so user can read screen
			system("clear");

			puts "Do you want to attack again? (y or n)";
			choice = gets.chomp;

			if(choice == 'n')
				attacking = false;
			end
		end
	end
end