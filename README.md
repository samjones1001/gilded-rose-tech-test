## Gilded Rose Kata
#### Technologies: Ruby, Rspec
### Week 10 tech test for [Makers Academy] (http://www.makersacademy.com)
[Outline](#outline) | [Usage Instructions](#usage-instructions) 

## Brief
"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper 
named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach 
their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, 
who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. 
First an introduction to our system:

All items have a SellIn value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how 
valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets 
interesting:

   * Once the sell by date has passed, Quality degrades twice as fast
   * The Quality of an item is never negative
   * “Aged Brie” actually increases in Quality the older it gets
   * The Quality of an item is never more than 50
   * “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
   * “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 
      days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

   * “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, do 
not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t 
believe in shared code ownership (you can make the UpdateQuality method and Items property static if you like, we’ll cover for you)."

## Outline
My first instinct on starting this challenge was to come up with a list of test cases covering all rules set out in the brief.  Once I was 
certain that I had all possible situations covered I created a spec file.  At this point I decided to omit the tests covering the conjured 
items which were to be added to the system, as I wanted to refator the existing code before adding any new functionality.

The first step in my refactor was to break up the large conditional in the update_quality method into smaller if/else statements containing 
only the rules for an individual type of item. This gave me better visibility on the rules governing each item, and meant that for my next
step I was able to remove all the neseted conditionals for better readabilty.

My next step was to remove the logic governing the rules for updating each type of item from the update_quality method into four new methods 
each dealing with one type of item.  The update_quality method now looked much cleaner, but it still had a large if/else statment that I 
wanted to remove.  At first, I dealth with this problem by extracting the update methods for each type of item into their own classes, then 
created a new ItemUpdater class which included a hash of items names and class names defined as a constant.  The update_quality method 
created a new instance of ItemUpdate and passed it the item to be updated.  The name of this items was then checked against the keys in the 
hash and the update method within the appropriate class was called.

While this approach worked well, each of the classes for the individual items were doing the same thing, just applying different rules to the 
update.  I decided to make a further alteration, removing these classes, and adding the rules they contained to my hash as procs.  
The ItemUpdater class continued to work in a similar way, but now called the appropraite proc on an item rather than delegating the update to
a sub-class.  At this point, I added the tests for conjured items to my spec file, and made them pass by adding the rules for conjured items
to my hash.

I am particularly happy with this solution as it remains open to easy modification; in order to add further classes of items, all this is 
needed is to add another proc to the hash - no other code needs to be edited.




## Usage Instructions
* clone the repo and run bundle
```shell
$ git clone https://github.com/samjones1001/gilded-rose-tech-test
$ cd gilded-rose-tech-test
$ rvm 2.3.0
$ bundle
```
* run tests
```shell
$ rspec
```
