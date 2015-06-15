Feature: Update Quantities
  In order to purchase differing quantities of items
  As a customer
  I want to be able to add/remove/change quantities of items in my cart

  Scenario: User updating product quantity
  Given I am on the checkout page with items in my cart
  And I update the quantity of a product
  Then the quantity of the product should be updated

  Scenario: User updating product quantity with faulty data
  Given I am on the checkout page with items in my cart
  And I update the quantity of a product with an invalid number (-1)
  Then the quantity of the product should not be updated

Feature: Shipping Estimates
  In order to guage how much I will be spending
  As a customer
  I want to be able to get an estimate of shipping
  
  Scenario: Shipping Estimate
  Given I am on the checkout page with items in my cart
  And I click on the estimate shipping button
  And I enter my address
  Then I should see a valid shipping estimate

Feature: Add Coupons
  In order to use coupons to save money
  As a savvy shopper
  I want to be able to add coupons in my cart
  
  Scenario: Adding a valid coupon
  Given I am on the checkout page with items in my cart
  And I enter a valid coupon code
  Then the price for that item should go down

  Scenario: Adding an invalid coupon
  Given I am on the checkout page with items in my cart
  And I enter an invalid coupon code
  Then it should notify me that I have entered an invalid coupon
  And the price for that item should not go down
  
Feature: Add item to cart
  Given I am on a product page
  And I click on the 'Add to cart' button
  Then it should add the item to my shopping cart

Feature: Clicking cart items
  In order to get to a product page
  As a customer
  I want to be able to click on a cart item

  Scenario: User clicking on an individual cart item
   Given I am on the checkout page with items in my cart
   And I click on a product in my cart
   Then I should be redirected to the product page
 
