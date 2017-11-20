require "./models/weapons/weapon"

class ChocolateBar < Weapon
	def initialize()
		@name = 'Chocolate Bar';
		@attack_modifier = Random.rand(2.0..2.4);
		@uses = 4;
	end
end