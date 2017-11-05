require "./models/monsters/monster"

class Person < Monster
	def initialize()
		@type = 'person'
		@health = 100
		@attack = -1
	end
end