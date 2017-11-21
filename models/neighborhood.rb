require "./models/home";
require "observer";

class Neighborhood include Observable
	def initialize(houseCount = 3)
		@houses = Array.new();

		for i in 1..houseCount do
			@houses << Home.new();
		end
	end

	attr_accessor :houses
end

class HomeCleansed
	def initialize(home)
		home.add_observer(self);
	end

	def update(home)
		if(home.getMonsterCount() == 0)
			home.cleared = true; # use this so I don't have to iterarate over monster array again and again
		end
	end
end