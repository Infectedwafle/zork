require "./models/monsters/ghoul";
require "./models/monsters/person";
require "./models/monsters/vampire";
require "./models/monsters/werewolf";
require "./models/monsters/zombie";
require "observer";

class Home
	def initialize()
		@poppulation = Random.rand(1..10);
		@monsters = Array.new();

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
			
			monster.add_observer(self);
			@monsters << monster;
		end
	end

	attr_accessor :monsters
	attr_accessor :poppulation
end