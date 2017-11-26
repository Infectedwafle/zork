require "./models/monsters/ghoul";
require "./models/monsters/person";
require "./models/monsters/vampire";
require "./models/monsters/werewolf";
require "./models/monsters/zombie";
require "observer";

class Home include Observable
	def initialize()
		# The total poppulation of the house
		@poppulation = Random.rand(1..10);
		# An array to store all monsters and persons
		@monsters = Array.new();
		# Poppulation of monsters in a home
		@monsterPopp = 0;

		# A loop to setup the monster list if the monster is a person we do not add it to the monsterPopp
		for i in 1..@poppulation do
			randNum = Random.rand(1..5);

			case randNum
			when 1
				monster = Ghoul.new();
				@monsterPopp = @monsterPopp + 1;
			when 2
				monster = Person.new(); #Not a monster
			when 3
				monster = Vampire.new();
				@monsterPopp = @monsterPopp + 1;
			when 4
				monster = Werewolf.new();
				@monsterPopp = @monsterPopp + 1;
			when 5
				monster = Zombie.new();
				@monsterPopp = @monsterPopp + 1;
			end
			
			# Add an observer to make sure that the monster is replaced with a person when defeated and monsterPopp is reduced 
			MonsterDefeated.new(monster);
			@monsters << monster;
		end
	end

	# Returns the monsterPopp of the home
	def getMonsterPoppulation()
		return @monsterPopp;
	end

	# Reduced the monsterPopp and notifies observers
	def reduceMonsterPopp()
		@monsterPopp = @monsterPopp - 1;
		changed;
		notify_observers();
	end

	# Prints the status of the home
	def getStatus()
		puts "#{self.getMonsterPoppulation()} monsters remaining";
	end

	# Prints the status of each monster in the house
	def monsterStats()
		@monsters.each do |monster|
			puts "#{monster.type} - Health: #{monster.health} Attack: #{monster.attack}";
		end
	end


	attr_accessor :monsters
	attr_accessor :poppulation
end

# Observer class to change monsters into persons and reduce the monsterPopp
# TODO: make this one work more like the observer in the neighborhood class file
# 		The observer should store the home it is on rather than pass it into the update function
class MonsterDefeated
	def initialize(monster)
		monster.add_observer(self);
	end

	def update(monster, home);
		if(monster != nil && home != nil)
			home.monsters[home.monsters.index(monster)] = Person.new();
			home.reduceMonsterPopp();
		end
	end
end