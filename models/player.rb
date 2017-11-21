require "./models/weapons/chocolate-bar";
require "./models/weapons/hershey-kiss";
require "./models/weapons/nerd-bomb";
require "./models/weapons/sour-straw";

class Player
	def initialize(name)
		@name = name
		@health = Random.rand(100..125);
		@attack = Random.rand(10..20);
		@inventory = Array.new();
		@location = 5;

		for i in 1..10 do
			randNum = Random.rand(1..4);

			case randNum
			when 1
				weapon = ChocolateBar.new();
			when 2
				weapon = HersheyKiss.new();
			when 3
				weapon = NerdBomb.new();
			when 4
				weapon = SourStraw.new();
			end
			
			@inventory << weapon;
		end
	end

	attr_accessor :name;
	attr_accessor :health;
	attr_accessor :attack;
	attr_accessor :location;
	attr_accessor :inventory;
end