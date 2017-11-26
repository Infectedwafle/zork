require "observer";
# Basic weapon class that all other weapons inherit
class Weapon include Observable
	def initialize()
		@name = 'weapon';
		@attack_modifier = 1;
		@uses = 1;
	end

	attr_accessor :name
	attr_accessor :attack_modifier
	attr_accessor :uses
end