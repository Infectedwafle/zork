class Command
	def initialize(type)
		@commands = Hash.new();

		if(type == "house")
			@commands["attack monster"] =	 "am";
			@commands["attack"] =			 "am";
			@commands["am"] =				 "am";
			@commands["house status"] =		 "hs";
			@commands["hs"] =				 "hs";
			@commands["show inventory"] =	 "si";
			@commands["si"] =				 "si";
			@commands["exit house"] =		 "eh";
			@commands["eh"] =				 "eh";
		elsif(type == "attack")
			@commands["a"] =				 "a";
			@commands["attack"] =			 "a";
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