require "./models/monsters/monster"

class Vampire < Monster
	def initialize()
		@type = 'vampire'
		@health = Random.rand(100..200)
		@attack = Random.rand(10..20)
	end
end