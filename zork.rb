require "./models/game";
require 'artii';

game = Game.new();
a = Artii::Base.new :font => 'slant'


puts a.asciify('ZORK!');
puts "1 - Start the Game";
puts "2 - Options";
puts "3 - Quit";

choice = gets.chomp.to_i;

if(choice == 1)
	game.start();
elsif(choice ==2)
	puts "Options will be available in a future update"
	# game.options();
else
	puts "You have made a cowardly choice and ran away."
	puts "You were later mauled by a wereworlf no one feels bad for you."
end