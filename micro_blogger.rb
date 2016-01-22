require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client
	
	def initialize
		puts "Initializing..."
		@client = JumpstartAuth.twitter
	end
	
	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "This tweet is #{message.length - 14} characters too long. Please shorten the tweet in order to post."
		end
	end
	
	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when 'q' then puts "Goodbye!"
				when 't' then tweet(parts[1..-1].join(" "))
				else
					puts "Sorry, I don't know how to #{command}"
			end
		end
	end	
	
end

blogger = MicroBlogger.new
blogger.run