class Monster
	def initialize(health, attack)
		@type = 'monster'
		@health = health;
		@attack = attack;
	end

	attr_accessor :type
	attr_accessor :health
	attr_accessor :attack
end

