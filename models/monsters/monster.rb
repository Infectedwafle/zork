require "observer";

# Simple monster class that all monsters inherit from
class Monster include Observable
	def initialize(health, attack)
		@type = 'monster'
		@health = health;
		@attack = attack;
	end

	def takeDamage(damage, home) 
		@health = @health - damage;
		if(@health <= 0)
			changed;
			notify_observers(self, home);
		end
	end

	attr_accessor :type
	attr_accessor :health
	attr_accessor :attack
end