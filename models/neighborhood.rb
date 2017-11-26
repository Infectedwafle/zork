require "./models/home";
require "observer";

class Neighborhood include Observable
	# initialize the neighborhood defaults to 9 houses 
	def initialize(houseCount = 9)
		# Array for holding the homes in the neighborhood
		@homes = Array.new();
		# The number of monsters in the neighborhood
		@monsterPopp = 0;

		# setup houses and add their mnsterPopp to the neighborhood monsterPopp and add observer for reducing the monsterPopp of the neighborhood
		for i in 1..houseCount do
			home = Home.new();
			@monsterPopp = @monsterPopp + home.getMonsterPoppulation();

			HomeCleansed.new(self, home);

			@homes << home
		end
	end

	# Return true if the neighborhood has been saved
	def all_clear()
		return @monsterPopp == 0;
	end

	# Prints the status of each home
	def stats
		for i in 1..@homes.length do
			puts "Home #{i} - #{@homes[i-1].getMonsterPoppulation()} Monsters Remaining";
		end
	end

	attr_accessor :homes
	attr_accessor :monsterPopp
end

# Observer Class that is used to update the neighborhood monsterPopp when a monster is defeated in a home
class HomeCleansed
	def initialize(neighborhood, home)
		@neighborhood = neighborhood;
		home.add_observer(self);
	end

	def update()
		@neighborhood.monsterPopp = @neighborhood.monsterPopp - 1;
	end
end