###The Testing Mindset
1. Specs and code change over time. What the developer had originally intended for the function to do may not be what it does now, and you should write test cases so you don't have any random bugs or unintended side effects in your codebase.
2. 
    *. Don't overtest. You should have tests that overall cover everything, but theres no reason to cover the same method numerous times.
    *. Write your tests right the first time. Its fine to go back and refactor your codebase, but your tests should be more or less perfect the first time you write them.
3. Always come into testing with the mindset that the program is inherently flawed and its your job to fix them. When testing your own code, you come into the process with your own biases (i.e. my code is fine, I wrote it). You should take the perspective of someone on the outside looking at your code with fresh eyes.

###Red -> Green -> Refactor
1. Start by writing tests. These will all fail (red). Once you get them all to pass (green), then you can refactor your code and make it better. But not until all the code passes the tests.