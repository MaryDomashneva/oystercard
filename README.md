[![Build Status](https://travis-ci.org/MaryDomashneva/oystercard-challenge.svg?branch=master)](https://travis-ci.org/MaryDomashneva/oystercard-challenge)

Oystercard Challenge
==================

Task
-----

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
Technology used
-----

* Ruby 2.5.0
* Rspec

Run project
-----

* In order to run tests, clone project, install ruby 2.5.0, install Rspec ```gem 'rspc'``` and ```rspec``` command in terminal.
* The easiest way to try project is in IRB: ```inside terminal irb -r./airoport_challenge```

Result
-----

* Oystercard allowes you to trevel between different tube stations.
* It can be top up, but the max amount is limited.
* Fare charges depend on travel zones.
* Minimum fare charge deducted from Oystercard balance when touch-in.
* Full fare charge deducted from Oystercard balance when touch-out.
* Penalty charges when failed touch-in or touch-out.
* As a user you can see Oyster card history.

Examples
-----
#1 Oystercard balance can be ```top_up``` with limited amount.
If the amount of top up exceed the maximum capasity the error will be raised.
```
2.5.0 :001 > oystercard = Oystercard.new
 => #<Oystercard:0x00007f95c58d0dd0 @balance=0, @journey_history=[], @current_journey=nil, @fare_calculator=#<FareCalculator:0x00007f95c58d0d80>> 
2.5.0 :002 > station_1 = Station.new(false, 1)
 => #<Station:0x00007f95c58a7228 @access=false, @zone=1> 
2.5.0 :003 > station_2 = Station.new(false, 5)
 => #<Station:0x00007f95c5886870 @access=false, @zone=5> 
2.5.0 :004 > oystercard.top_up(50)
 => 50 
2.5.0 :005 > oystercard.top_up(50)
Traceback (most recent call last):
        3: from /Users/mariagetmanova/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        2: from (irb):6
        1: from /Users/mariagetmanova/Desktop/Makers_Projects/oystercard/lib/oystercard.rb:25:in `top_up'
RuntimeError (The amount you are trying to top up is above limit = 90 GBR)
```
#2 Oystercard can be in journey when ```touch_in```
```
2.5.0 :006 > oystercard.touch_in(station_1)
 => true 
2.5.0 :007 > oystercard.in_journey?
 => true 
2.5.0 :008 > 
```
#3 Oystercard finishes journey when ```touch_out```
```
2.5.0 :009 > oystercard.touch_out(station_2)
 => false 
2.5.0 :010 > oystercard.in_journey?
 => false 
2.5.0 :011 > 
```
#4 It deducts fare charges and updates balance depending on zones with initial ```MINIMUM_FARE = 1```
```
2.5.0 :011 > oystercard.balance
 => 45 
```
#5 It charges penalty = 6 plus minimum fare charge = 1, when fail ```touch_out```. Should deduct 7 out of balance = 45. New balance should be = 38
```
2.5.0 :014 > station_3 = Station.new(false, 1)
 => #<Station:0x00007f95c58b6b88 @access=false, @zone=1> 
2.5.0 :015 > station_4 = Station.new(false, 4)
 => #<Station:0x00007f95c58aef78 @access=false, @zone=4> 
2.5.0 :016 > oystercard.touch_in(station_3)
 => true 
2.5.0 :017 > oystercard.balance
 => 45 
2.5.0 :018 > oystercard.touch_in(station_4)
 => true 
2.5.0 :019 > oystercard.balance
 => 38 
2.5.0 :020 > 
```
#5 It charges penalty = 6 plus minimum fare charge = 1, when fail ```touch_in```. Should deduct 7 out of balance = 50. New balance should be = 43
```
2.5.0 :001 > oystercard = Oystercard.new
 => #<Oystercard:0x00007fad288c0780 @balance=0, @journey_history=[], @current_journey=nil, @fare_calculator=#<FareCalculator:0x00007fad288c0730>> 
2.5.0 :002 > station_1 = Station.new(false, 1)
 => #<Station:0x00007fad288a5048 @access=false, @zone=1> 
2.5.0 :003 > station_2 = Station.new(false, 4)
 => #<Station:0x00007fad288373e0 @access=false, @zone=4> 
2.5.0 :004 > oystercard.top_up(50)
 => 50 
2.5.0 :005 > oystercard.balance
 => 50 
2.5.0 :006 > oystercard.touch_out(station_2)
 => 43 
2.5.0 :007 > oystercard.balance
 => 43 
2.5.0 :008 > 
```
