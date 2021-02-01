# 1. Concurrency

# Fibers introduced in Ruby 1.9:
# https://www.infoq.com/news/2007/08/ruby-1-9-fibers/

fib = Fiber.new do
  x, y = 0, 1
  loop do
    Fiber.yield y
    x, y = y, x + y
  end
end

puts 'Using fibers to print the Fibonnaci sequence:'

10.times { puts fib.resume }

puts '---'

# Non-blocking fibers in Ruby 3.0, using the Async scheduler
# implementation: https://github.com/socketry/async

require 'async'

def perform_task(duration:, name:)
	Async do |task|
		task.sleep duration
		puts "#{name} complete"
	end
end

puts 'Using non-blocking fibers for async tasks:'

Async do
	perform_task(duration: 2, name: 'First Task')
	perform_task(duration: 1, name: 'Second Task')
end

puts '---'

# Ractors for thread-safe parallel execution

puts 'Creating a ractor server...'

server = Ractor.new do
  puts "Server starts: #{self.inspect}"
  Ractor.yield 'Greetings 👋'
  received = Ractor.recv
  puts "Server received a message: #{received}"
end

puts 'Creating a client for the ractor server...'

client = Ractor.new(server) do |srv|
  puts "Client starts: #{self.inspect}"
  received = srv.take
  puts "Client received a messsage from #{srv.inspect}: #{received}"
  srv.send 'Howdy 🤠'
end

[client, server].each(&:take) # wait for results

puts '---'

# 2. Rightward assignment

2 * 2 => x

puts 'Rightward assignment result:'
puts x
puts '---'

# 3. Static types and type checking

# Note: The following example code will only work once you've completed the
# steps in the mini-tutorial "Static Types and Type Checking".

# require './example_course.rb'
# puts 'A statically-typed course:'
# puts ExampleCourse.new(name: 'Python for Beginners').inspect
# puts '---'

# 4. Endless method definition

def endless_method(num) = num * 2

puts 'Endless method call result:'
puts endless_method(5)
puts '---'
