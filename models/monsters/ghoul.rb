require "./models/monsters/monster"

class Ghoul < Monster
	def initialize()
		@type = 'ghoul'
		@health = Random.rand(40..80)
		@attack = Random.rand(15..30)
	end
end