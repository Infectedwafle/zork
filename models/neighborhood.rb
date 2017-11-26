require "./models/home";
require "observer";

class Neighborhood include Observable
	def initialize(houseCount = 3)
		@homes = Array.new();
		@monsterPopp = 0;

		for i in 1..houseCount do
			home = Home.new();
			@monsterPopp = @monsterPopp + home.getMonsterPoppulation();

			HomeCleansed.new(self, home);

			@homes << home
		end
	end

	def all_clear()
		cleansedHouses = @homes.select { |h| h.getMonsterPoppulation == 0};
		return cleansedHouses.length == @homes.length;
	end

	def stats
		for i in 1..@homes.length do
			puts "Home #{i} - #{@homes[i-1].getMonsterPoppulation()} Monsters Remaining";
		end
	end

	attr_accessor :homes
	attr_accessor :monsterPopp
end

class HomeCleansed
	def initialize(neighborhood, home)
		@neighborhood = neighborhood;
		home.add_observer(self);
	end

	def update()
		@neighborhood.monsterPopp = @neighborhood.monsterPopp - 1;
	end
end