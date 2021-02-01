# Three Interesting Features in Ruby 3.0

## Getting Started

1. Install Ruby 3.0 using your preferred method, e.g. rbenv, rvm
2. Clone this project and navigate into the main directory
3. Run `bundle install` from within the project directory
4. Run `ruby examples.rb` to see the output of the given examples
5. Complete any of the short tutorials below if you're interested in looking more closely at the new Ruby 3.0 features described

## Intro Tutorial #1: New Concurrency Features

1. Create an empty file called `tutorial_1.rb` in the project directory
2. Fibers were [originally introduced in Ruby 1.9](https://www.infoq.com/news/2007/08/ruby-1-9-fibers/), adding lightweight concurrency via code blocks that can be paused and resumed, offering concurrency (although not parallelism) as shown here:
   ![concurrency vs parallelism](https://images.squarespace-cdn.com/content/v1/562ea223e4b0e0b9dab0b930/1567230852223-R1D5NTFFUWKX98UNW479/ke17ZwdGBToddI8pDm48kEBP2J4qC6JzpPJ1TfhRUE1Zw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZamWLI2zvYWH8K3-s_4yszcp2ryTI0HqTOaaUohrI8PIpAcrfHy5pvMwnm_saE6HkRfpElANzITP95e7x2FOGm0/concurrency_vs_parallelism.png?format=500w)

Just as a process can contain multiple threads, a thread can contain multiple fibers ([more on that here](https://appfolio-engineering.squarespace.com/appfolio-engineering/2019/9/13/benchmarking-fibers-threads-and-processes)).

To try fibers out, add the following code to `tutorial_1.rb`:

```ruby
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
```

3. Run `ruby tutorial_1.rb` to see the output
4. Notice the line of code in Step 2 above that calls `fib.resume` - update the number here to print out an additional 10 elements of the Fibonacci sequence, and re-run `ruby tutorial_1.rb` to check the output
5. Next, by choosing a scheduler implementation (we'll use the [Async](https://github.com/socketry/async) gem), we can implement non-blocking fibers. The Async gem provides a simple interface for asynchronous features (see [docs](https://socketry.github.io/async/guides/getting-started/index.html)), which we can try out now by adding the following code to `tutorial_1.rb`:

```ruby
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
```

4. Run `ruby tutorial_1.rb` from the project directory to see the output and confirm that the tasks complete in the expected order
5. Finally, Ruby 3.0 also introduces Ractors for parallel execution without thread-safety concerns. Add the following code to `tutorial_1.rb` to test out a ractor:

```ruby
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
```

6. Run `ruby tutorial_1.rb` to see the results
7. Update the ractor code from Step 5 to add a new client that replies to the server's greeting

## Intro Tutorial #2: Rightward Assignment

1. Create an empty file called `tutorial_2.rb` in the project directory
2. Add the following line to the file:

```ruby
  2 * 2 => x
```

3. Add the following line to the file:

```ruby
  puts x
```

4. Run `ruby tutorial_2.rb` from the project directory

## Intro Tutorial #3: Static Types and Type Checking

1. Run `steep init` from the project directory and open the newly-created `Steepfile` to see whether the configuration looks suitable (compare to the provided `Steepfile_example` if needed)
2. Create an empty file called `example_course.rb` in the project directory
3. Add the following to `example_course.rb`:

```ruby
class ExampleCourse
  attr_reader :name

  def initialize(name:)
    @name = name
  end
end
```

4. Run the following from the project directory to generate a signature file with type information about the entity defined in `example_course.rb` (notice the `.rb` vs `.rbs` file types):

```bash
rbs prototype rb example_course.rb > example_course.rbs
```

5. Open up `example_course.rbs` (the signature file) - updating your editor settings to use Ruby language settings, if it doesn't immediately recognise the file type - and look to see where `untyped` values could be updated to be defined types
6. Run `steep check` from the project directory to discover any issues with the type signature that you have defined (and test this command by deliberately setting an incorrect type for a method argument or return value)
7. Run the following from the project directory to have Steep confirm that all of the entities defined in this project are typed:

```bash
steep stats --log-level=fatal | awk -F',' '{ printf "%-28s %-9s %-12s %-14s %-10s\n", $2, $3, $4, $5, $7 }'
```

## Bonus: Endless Method Definitions

Tidy utility methods FTW!

```ruby
def square(x) = x * x
```

---

### Sources

- https://www.ruby-lang.org/en/news/2020/09/25/ruby-3-0-0-preview1-released/
- https://www.ruby-lang.org/en/news/2020/12/08/ruby-3-0-0-preview2-released/
- https://docs.ruby-lang.org/en/3.0.0/doc/ractor_md.html
- [(EN) Don't Wait For Me! Scalable Concurrency for Ruby 3! / Samuel Williams @ioquatix](https://www.youtube.com/watch?v=Y29SSOS4UOc)
- [Ruby 3.0 brings new type checking and concurrency features](https://lwn.net/Articles/833560/)
