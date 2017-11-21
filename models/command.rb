class Command
	def initialize(type)
		@commands = Hash.new();

		if(type == "house")

		else
			@commands["left"] =				 "left";
			@commands["west"] =				 "left";
			@commands["right"] =			 "right";
			@commands["east"] =				 "right";
			@commands["up"] =				 "up";
			@commands["north"] =			 "up";
			@commands["down"] =				 "down";
			@commands["south"] =			 "down";
			@commands["show inventory"] =	 "si";
			@commands["si"] =				 "si";
			@commands["show map"] =			 "sm";
			@commands["sm"] =				 "sm";
			@commands["enter home"] =		 "eh";
			@commands["eh"] =				 "eh";
		end
	end

	def getCommand()
		command = gets.chomp;
		return @commands[command];
	end

	attr_reader :commands
end