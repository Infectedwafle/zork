require "observer";

class Monster include Observable
	def initialize(health, attack)
		@type = 'monster'
		@health = health;
		@attack = attack;
	end

	def takeDamage(damage) 
		@health = @health - damage;
		changed;
		notify_observers(self, @health);
	end

	def attack(monster, weapon)
		monster.takeDamage(@attack * weapon.attack_modifier);
	end

	attr_accessor :type
	attr_accessor :health
	attr_accessor :attack
end