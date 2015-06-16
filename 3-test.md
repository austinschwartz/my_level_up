###The Testing Mindset
1. Specs and code change over time. What the developer had originally intended for the function to do may not be what it does now, and you should write test cases so you don't have any random bugs or unintended side effects in your codebase.
2. 
    *. Don't overtest. You should have tests that overall cover everything, but theres no reason to cover the same method numerous times.
    *. Write your tests right the first time. Its fine to go back and refactor your codebase, but your tests should be more or less perfect the first time you write them.
3. Always come into testing with the mindset that the program is inherently flawed and its your job to fix them. When testing your own code, you come into the process with your own biases (i.e. my code is fine, I wrote it). You should take the perspective of someone on the outside looking at your code with fresh eyes.

###Red -> Green -> Refactor
1. Start by writing tests. These will all fail (red). Once you get them all to pass (green), then you can refactor your code and make it better. But not until all the code passes the tests.

###Your Toolbelt
1. Unit tests with RSpec, where we testing individual methods of our class in isolation. Integration tests with Cucumber, where we test systems of code not in isolation.
2. Acceptence tests with Capybara (i.e. a scenario where a user enters a code into the textbox onto the website. This can't really be tested without a driver.

###Capybara
1. Acceptance tests. They're useful for testing where the user interacts with the application. It's limited in its ability to test the internals and also its very dependent on what driver you use. It also might break tests whenever html is changed.
2. Examples of drivers are selenium, phantomjs. A driver is the interface that capybara interacts with your application through. The default driver does not run JS, but it seems to be fast and easy to set up. It also does not require a server to run.
3. Testing any javascript code or some login authorizarions like oath would require a different driver.

### Flapping Tests
1. Flapping tests are tests that fail randomly and are difficult to reproduce. Because they are consistant, they are hard to debug.
2. Don't depend on timing (wait, sleeps) or other tests. Your tests should not use another test as a precondition.

### It's Not All Automatic
1. A lot of pixel perfect website details can't really be automatically tested without a tool like browserling. Also, many desktop applications don't really have tool support for automated testing.
2. Manually test only what is mission critical. Small UI changes may go by the wayside if you have many things to test.

### Happy Path/etc
1. Inputting badly formatted codes into overlord was bad path. Testing correct codes was happy path. Inputting the wrong codes in order to detonate the bomb was sad path. I think all of my data science tests were happy path.
2. To-Do: add tests to the data science exercise 

### Strategies for better testing
1. You start with writing view code, taking the perspective of a user viewing the website. This allows you to visualize what the final product will look like even before you start writing the underlying logic. This makes it easier to create minimal functions and implementations.
2. Lets say that we're writing an addition to a blogging website, that adds a calendar and a list of tags for whatever blog posts. If one was so inclined to write the code for this first, they might completely overcomplicate it, bringing in other frameworks, or introducing unnecessary features into the website. Writing the tests first, including tests for each new feature that you want, will end up with the codebase having exactly the minimal code needed.

### Tautological Testing
1. Lets say we have a Calculator module with sum and modulus functions.

module Calculator
  def self.sum(a, b)
    a + b
  end 

  def self.mod(a, b)
    a - (b * (a/b))
  end
end 

A test like this would be tautological

describe Calculator do
  it 'should return the correct sum' do
    expect { Calculator.sum(6, 10) }
    .to eq(6 + 10)
  end
  
  it 'should return the correct modulus' do
    expect { Calculator.mod(17, 7) } do
    .to eq(17 % 10)
  end
end

The example is vey basic, but in this test, we are testing the Calculator functions with their equivalent code, which in effect, doesn't test anything. We should be comparing the functions with the correct value (mod(17, 7) == 10)


