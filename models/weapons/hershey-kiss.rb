require "./models/weapons/weapon"

class HersheyKiss < Weapon
	def initialize()
		@name = 'Hershey Kiss'
		@attack_modifier = 1
		@uses = -1;
	end
end