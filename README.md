# Three Interesting Features in Ruby 3.0

## Getting Started

1. Install Ruby 3.0 using your preferred method, e.g. rbenv, rvm
2. Clone this project and navigate into the main directory
3. Run `bundle install` from within the project directory
4. Run `ruby examples.rb` to see the output of the given examples
5. Complete any of the short tutorials below if you're interested in looking more closely at the new Ruby 3.0 features described

## Intro Tutorial #1: New Concurrency Features

1. Create an empty file called `tutorial_1.rb` in the project directory
2.
3.
4. Run `ruby tutorial_1.rb` from the project directory

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
5. [shocked_pikachu.jpeg](#)

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

(I had to look at this example for a full second to understand what was happening.)

```ruby
def square(x) = x * x
```

### Sources

- https://www.ruby-lang.org/en/news/2020/09/25/ruby-3-0-0-preview1-released/
- https://www.ruby-lang.org/en/news/2020/12/08/ruby-3-0-0-preview2-released/
- [(EN) Don't Wait For Me! Scalable Concurrency for Ruby 3! / Samuel Williams @ioquatix](https://www.youtube.com/watch?v=Y29SSOS4UOc)
