require "./models/monsters/monster"

# Person monster class they are freidlies so they cannot take damage
class Person < Monster
	def initialize()
		@type = 'person'
		@health = 100
		# Attack is -1 so that it heals the player
		@attack = -1
	end

	def takeDamage(damage) 
		#does not take damage
	end
end