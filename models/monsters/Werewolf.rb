require "./models/monsters/monster"

class Werewolf < Monster
	def initialize()
		@type = 'werewolf'
		@health = 200
		@attack = Random.rand(0..40)
	end
end