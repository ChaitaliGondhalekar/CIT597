CIT 597 Homework 2
Submitted by Chaitali Gondhalekar

Part 1 

Hw2p1.rb

The class RationalNum represents a rational number. It implements various operations on rational numbers viz. addition, subtraction, multiplication, division. 

Part 2
Country.rb
Hw2p2.rb

To retrieve the webpage, I have used Nokogiri library(HTML open method). After reading the page, I filtered out links to individual country pages. Then accessed the pages to get all the information available about each country. After examining the contents carefully, I figured out which sections contain the required information.
I extracted the data from the page in an array. Using a method getParameters, I stored the information with headings as key in hash and corresponding information as value. Then created an instance of class Country per country, made an array of such instances, so that the data related to each country is now stored in instance variables.

Next, the given questions are printed on the console one by one and  the user is asked to put in certain parameters according to which the answers are obtained and printed on the console.
To get the continent of the country, the Hashmap variable associated with each country is traversed to get the value with key "Map reference".
Similarly, the other parameters were found using related mentioned keys.
e.g. hemisphere - Geographical coordinates, etc

To find hazard prone countries,
at first, hazard and continent was accepted from user as input. Then data corresponding to “Natural hazards” was searched for given hazard, if found, the country is considered to be hazard-prone.
(Assumptions for continents: Central America and Caribbean = North America, Middle East = Asia, Australia = Oceania)

To find lowest elevation point, the data corresponding to Elevation extremes was searched for lowest point (in m). The country with lowest number was output as the answer.

Hemisphere assumptions: There are just 4 hemispheres - SE, SW, NE, NW
Political Parties assumptions: countries whose data is given in format:
Party name [leader name] are considered

Highest Electricity consumption unit is kWh per capita

To get country landlocked by single country, land boundaries are searched for “km” keyword and desired inference is drawn.


