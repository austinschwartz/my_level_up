###Ruby Core
1. ```"abcd".tr('ab', '12')```

###Stylish (and Sane) Ruby
1. Not sure how to get it lower

    ```
    λ triangle_facts (master) ✗ rubocop triangle_facts.rb
    Inspecting 1 file
    C
    
    Offenses:
    
    triangle_facts.rb:23:3: C: Assignment Branch Condition size for recite_facts is too high. [16.52/15]
      def recite_facts
      ^^^
    triangle_facts.rb:23:3: C: Method has too many lines. [8/7]
      def recite_facts
    ~  22
      ^^^
    triangle_facts.rb:34:3: C: Assignment Branch Condition size for calculate_angles is too high. [30.59/15]
      def calculate_angles(a, b, c)
      ^^^
    triangle_facts.rb:50:1: C: Extra blank line detected.
    
    1 file inspected, 4 offenses detected
  ```
2. Rubocop complains that I'm using double quoted strings, but the style guide says to use them.

## Knows what the five second rule for code review is
1. The Five Second Rule for code review means that the person reviewing the code should have a basic understanding of what the code does within a short five second glance.

###Comments
1. The comments might not accurately reflect the code, could be dated
2. The code itself should be self-explanatory
3. ^

