require "./models/weapons/chocolate-bar";
require "./models/weapons/hershey-kiss";
require "./models/weapons/nerd-bomb";
require "./models/weapons/sour-straw";

class Player
	def initialize(name)
		@name = name
		@maxHealth = Random.rand(100..125);
		@health = @maxHealth;
		@attack = Random.rand(10..20);
		@inventory = Array.new();
		@location = 5;

		@inventory << HersheyKiss.new(); #Only add one of these to inventory since it has unlimited uses
		for i in 1..9 do
			randNum = Random.rand(1..3);

			case randNum
			when 1
				weapon = ChocolateBar.new();
			when 2
				weapon = SourStraw.new();
			when 3
				weapon = NerdBomb.new();
			end
			
			@inventory << weapon;
		end
	end

	def takeDamage(damage)
		@health = @health - damage;

		if @health < 0
			@health = 0;
		end

		if(@health > @maxHealth)
			@health = @maxHealth;
		end
	end

	def stats()
		puts "Player Health: #{@health}/#{@maxHealth}";
		puts "Player Attack: #{@attack}";
	end

	attr_accessor :name;
	attr_accessor :health;
	attr_accessor :attack;
	attr_accessor :location;
	attr_accessor :inventory;
end