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
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				when 'spam' then spam_my_followers(parts[1..-1].join(" "))
				else
					puts "Sorry, I don't know how to #{command}"
			end
		end
	end	
	
	def dm(target, message)
		puts "Tryng to send #{target} this direct message:"
		puts message
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
		if screen_names.include? (target)
			message = "d @#{target} #{message}"
			tweet(message)
		else
			puts "Message not sent (target is not a follower)" 
		end
	end
	
	def followers_list
		screen_names = []
		@client.followers.each do |follower|
			screen_names << @client.user(follower).screen_name
		end
		screen_names
	end
	
	def spam_my_followers(message)
		followers_list.each do |follower|
			dm(follower, message)
		end
	end
end

blogger = MicroBlogger.new
blogger.run