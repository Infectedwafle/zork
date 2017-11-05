require "./models/monsters/monster"

class Zombie < Monster
	def initialize()
		@type = 'zombie'
		@health = Random.rand(50..100)
		@attack = Random.rand(0..10)
	end
end