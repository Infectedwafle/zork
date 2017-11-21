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
		@cleared = false;

		for i in 1..@poppulation do
			randNum = Random.rand(1..5);

			case randNum
			when 1
				monster = Ghoul.new();
			when 2
				monster = Person.new();
			when 3
				monster = Vampire.new();
			when 4
				monster = Werewolf.new();
			when 5
				monster = Zombie.new();
			end
			
			self.add_observer(MonsterDefeated.new(monster));
			@monsters << monster;
		end
	end

	def getMonsterCount()
		tempMonsters = @monsters.select { |m| m.type != 'person'}; 
		return tempMonsters.length;
	end


	attr_accessor :monsters
	attr_accessor :poppulation
end

class MonsterDefeated
	def initialize(monster)
		monster.add_observer(self);
	end

	def update(monster, health)

		if(monster.health <= 0)
			monster.type = 'person';
			monster.health = 100;
			monster.attack = -1;
		end
	end
end