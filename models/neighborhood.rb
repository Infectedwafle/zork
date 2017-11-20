require "./models/home";

class Neighborhood
	def initialize(houseCount = 3)
		@houses = Array.new();

		for i in 1..houseCount do
			@houses << Home.new();
		end
	end

	attr_accessor :houses
end