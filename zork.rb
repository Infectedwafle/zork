require "./models/neighborhood";

neighborhood = Neighborhood.new();

for home in neighborhood.houses do
	puts home.poppulation
	for monster in home.monsters do
		puts monster.type
	end
end