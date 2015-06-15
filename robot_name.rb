class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  ERROR_MSG = 'There was a problem generating the robot name!'

  def initialize(args = {})
    @registry ||= []
    @name_generator = args[:name_generator]
    @name = @name_generator ? @name_generator.call : standard_name_gen
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @registry.include?(name)
      raise NameCollisionError, ERROR_MSG
    end
    @registry << @name
  end

  def standard_name_gen
    "#{generate_char}#{generate_char}#{generate_num} \
      #{generate_num}#{generate_num}"
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
