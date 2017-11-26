#######################################################################################
# Zork Asimple text based RPG using ruby
# 
# By Kevin Anderson Fall 2017
#######################################################################################

require "./models/game";
require 'artii';

# Setup Game and Ascii Art
game = Game.new();
a = Artii::Base.new :font => 'slant'

system("clear");
puts a.asciify('ZORK!');
puts "1 - Start the Game";
puts "2 - Options";
puts "3 - Exit";

choice = gets.chomp.to_i;
# Handle users choice
if(choice == 1)
	system("clear");
	game.start();
	game.runLoop();
elsif(choice == 2)
	puts "Options will be available in a future update"
	# game.options();
else
	puts "You have made a cowardly choice and ran away."
	puts "You were later mauled by a wereworlf no one feels bad for you."
end