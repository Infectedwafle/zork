require "./models/monsters/ghoul";
require "./models/monsters/person";
require "./models/monsters/vampire";
require "./models/monsters/werewolf";
require "./models/monsters/zombie";
require "observer";

class Home include Observable
	def initialize()
		@poppulation = Random.rand(1..10);
		@monsters = Array.new();
		@monsterPopp = 0;

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
			
			MonsterDefeated.new(monster);
			@monsters << monster;
		end
	end

	def getMonsterPoppulation()
		return @monsterPopp;
	end

	def reduceMonsterPopp()
		@monsterPopp = @monsterPopp - 1;
		changed;
		notify_observers();
	end

	def getStatus()
		puts "#{self.getMonsterCount()} monsters remaining";
	end

	def monsterStats()
		@monsters.each do |monster|
			puts "#{monster.type} - Health: #{monster.health}";
		end
	end


	attr_accessor :monsters
	attr_accessor :poppulation
end

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