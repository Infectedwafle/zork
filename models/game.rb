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
		puts "Your neighborhood has been overrun with monsters.";
		puts "You have been tasked with clearing the area of all monsters.";
		
		puts "\n\nWhat is your name?";
		name = gets.chomp;
		@player = Player.new(name);
		system('cls');
		puts "#{@player.name} you are standing in front of your house at the center of your neighborhood";
	end

	def runLoop()
		gameWon = false;
		neighborhoodCommands = Command.new(nil);
		houseCommands = Command.new("house");
		home = nil; 
		
		while(!gameWon)
			puts "#{home}";
			if(home === nil)
				home = neighborhoodLoop(neighborhoodCommands, home);
			else
				homeLoop(houseCommands, home);
				home = nil;
			end

			if(@neighborhood.all_clear())
				gameWon = true;
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
					puts "#{weapon.name}\t-\tUnlimited uses";
				else
					puts "#{weapon.name}\t-\t#{weapon.uses} uses";
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

	def homeLoop(commands, home)
		attackCommands = Command.new("attack")
		while(true) #wait for commands until house exited
			case commands.getCommand()
			
			when 'am'
				attackLoop(attackCommands, home)
			when 'hs'
				# Show staus of house here
				home.getStatus();
			when 'si'
				# show remaining inventory
			when 'eh'
				# exit the house
				puts puts "You exited house number #{@player.location}"
				return nil;
			else
				puts "That is not a command.";
			end
		end
	end

	def attackLoop(commands, home)
		attacking = true;

		while attacking
			case commands.getCommand()
			when 'a'
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
					if(monster.type != 'person')
						damage = @player.attack * weapon.attack_modifier;
						monster.takeDamage(damage);
						puts "You damaged #{monster.type} with #{weapon.name} for #{damage}";
					end
				end

				# Monsters Attack
				home.monsters.each do |monster|
					@player.takeDamage(monster.attack);
					puts "#{monster.type} hit you for #{monster.attack}";
				end
			else
				puts "That is not a command";
			end
		end
	end
end