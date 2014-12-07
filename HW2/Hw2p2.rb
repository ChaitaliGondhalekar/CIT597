require_relative 'country'
require 'nokogiri'
require 'open-uri'

# calls other methods
def main
  page = "https://www.cia.gov/library/publications/the-world-factbook/print/textversion.html"
  linkArray = Array.new
  infoArray = Array.new
  parameterArray = Array.new
  countryList = Array.new
  parameterList = getDesiredParameters
  getPage(page) {|countrylink| linkArray << countrylink} #countryArray.add(Country.new(countryLink[0],countryLink))
  linkArray.each do |link| #for each country link
    extractInfo(link) {|infoArray| # array with info about country
      parameterArray.clear()
      unless infoArray.empty?
        parameterList.each do |p| #list of parameters
          parameterArray << p << getParameter(infoArray,p) if getParameter(infoArray,p) #getting parameter values for the country
        end #do |p|
      end #unless
    } 
    #make a country object with all the info, put it in an array
    countryList << Country.new(parameterArray[1],parameterArray[2..-1]) unless parameterArray.empty?
  end #do linkArray
  #ask for input from user
  inputFromUser(countryList)
end #main

#
def inputFromUser (countryList)
  
  puts "Welcome to Trivia!"
  puts "Q1 To find countries in a continent, prone to a natural hazard"
  hazardProneCountry(countryList)
  
  puts "Q2 Country with lowest elavation point in a continent"
  lowestElevationPoint(countryList)
  
  puts "Q3 All countries in one of the given hemisphere: northwestern, northeastern, southeastern, southwestern"
  conutryInHemisphere(countryList)
  
  puts "Q4 countires in a continent with more than a given number of political parties"
  politicalParties(countryList)
 
  puts "Q5 Top x countries with highest electricity consumption per capita"
  highestElectricityCons(countryList)
  
  #incomplete
  # puts "Q6 Coutries where dominent religion accounts for more than x% or less than y% of population"
#getDomRel(countryList)
  
  #done
  puts "Q7 Find all the landlocked countries"
  getLandlocked(countryList)
  
  #incomplete
  # puts "Q8 Country with Longest Railroad length"
#   answer = getRailroad
#   puts "None" if answer.empty?
#   puts answer.to_s
 
end

# prints countries from given continent prone to given natural hazard
def hazardProneCountry(countryList)
  
  puts "Please enter one of the 5 continents: Asia, Africa, Europe, North America, Oceania, South America"
  continent = gets
  puts "please enter the natural hazard"
  hazard = gets  
  str = "Natural hazards"
  answer = Array.new
  countryList.each do |country|
    paraHash = country.paraHash
    mapRef = paraHash["Map references"]
    mapRef = resolveContinent(mapRef)
    if mapRef==continent
      s = paraHash[str]
      if s =~ /#{hazard}/
        answer << country.name
      end #if
    end
  end #def
  puts "#{hazard} prone countries in #{continent} are:"
  puts "None" if answer.empty?
  puts answer
end

# convert ambiguous continents
def resolveContinent(continent)
  ambiguity = ["Central America and Caribbean", "Middle East", "Australia"]
  if ambiguity.include?(continent)
    continent = "North America" if continent == "Central America and Caribbean"
    continent = "Asia" if continent == "Middle East"
    continent = "Australia" if continent == "Oceania"
  end #if
  continent
end

def lowestElevationPoint(countryList)
  puts "Please enter one of the 5 continents: Asia, Africa, Europe, North America, Oceania, South America"
  continent = gets  
  continent = resolveContinent(continent)
  answer = Hash.new
  elevation = Hash.new
  countryList.each do |country|
    mapRef = country.paraHash["Map references"]
    mapRef = resolveContinent(mapRef)
    if mapRef==continent
      answer.store(country.name, country.paraHash["Elevation extremes"])
    end
  end #do
  
  lowestEle,ele = 100000,0 #random value that cannot be lowest
  lowEleCountry = ""
  answer.each do |key, value|
    ele = value.scan(/\d+/).first
    if ele.to_i <= lowestEle.to_i
      lowestEle = ele
      lowEleCountry = key
    end
  end
end

# print countries in given hemisphere
def conutryInHemisphere(countryList)
  puts "Please enter the hemisphere"
  hemisphere = gets
  hemis = convertToDirections(hemisphere)
  answer = Array.new
  countryList.each do |country|
    dir = ""
    coords = country.paraHash["Geographic coordinates"]
    dir << coords.scan(/\p{Upper}/)[0] << coords.scan(/\p{Upper}/)[1] unless coords==nil
    if hemis == dir
      answer << country.name 
    end
  end
  puts "All the countries in #{hemisphere} hemisphere are:"
  puts "None" if answer.empty?
  puts answer
end

# convert hemisphere to direction initials
def convertToDirections(hs)
  h = "SE" if hs =="Southeastern"
  h = "SW" if hs=="Southwestern"
  h = "NE" if hs=="Northeastern" 
  h = "NW" if hs=="Northwestern"
  puts h
  h
end

# print countries with more than given poilitical parties from given continent
def politicalParties(countryList)
  puts "Please enter the continent"
  continent  = gets
  puts "Please enter the number"
  number = gets
  number = 1
  
  continent = resolveContinent(continent)
  answer = Array.new
  countryList.each do |country|
    mapRef = country.paraHash["Map references"]
    mapRef = resolveContinent(mapRef)
    if mapRef==continent
      p = country.paraHash["Political parties and leaders"]
      unless p==nil
        answer << country.name if p.scan(/\[/).count > number
      end
    end
  end #do
  puts "Countries in #{continent} with more than #{number} political parties are:"
  puts "None" if answer.empty?
  puts answer
end

# prints top countries with highest electricity consumption per capita
def highestElectricityCons(countryList)
  puts "Enter x"
  x = gets
  highest = 0
  answer = Array.new
  countryList.each do |country|
    population = country.paraHash["Population"].gsub(",","")
    num = population.scan(/\d+/).first.to_i
    eleCons = getEleCons(country.paraHash["Electricity - consumption"])
    answer << country.name if (eleCons/num)>highest
  end
  puts "Top #{x} countries with highest electricity consumption per capita are:"
  puts answer[0..x-1]
end

# return electricity consumption in kWh
def getEleCons(s)
  mul = 10**9 if s.scan(/billion/)
  mul = 10**6 if s.scan(/million/)
    if float_match = s.scan(/(\d+[.,]\d+)/).flatten.first
      # converting matched string to float
      float = float_match.tr(',', '.').to_f
      puts float
    end
  total = float * mul
end

# get dominent religion in a country from the list of countries
def getDomRel(countryList)
  puts "Enter x"
  x = gets
  puts "Enter y"
  y = gets
  answer = Array.new
  countryList.each do |country|
    r = country.paraHash["Religions"]
    puts r
    percentRel = r.scan(/\d{1,2}\%/)
    rel = r.scan(/^[a-zA-Z]+$\d{1,2}\%/)
    puts "religions"
    puts rel
  end
  
end

# obtain country landloacked by single country
def getLandlocked(countryList)
  
  answer = Array.new
  str = 'landlocked'
  countryList.each do |country|
    coast = country.paraHash["Coastline"]
    puts coast
    b = country.paraHash["Land boundaries"] unless coast==nil && ! (coast =~ /#{str}/)
    puts b
    answer << country.name if b.scan(/km/).count == 2
  end #do
  puts "Countries Landlocked by a signle countries are:"
  puts "None" if answer.empty?
  puts answer
 
end

# incomplete
# def getRel(countryList)
#   puts "Please enter"
#   puts "None" if answer.empty?
#   puts answer.to_s
# end

# return the categories/heading used on the webpage to get required information
def getDesiredParameters()
  
  parameters = Array.new
  parameters << "Country"
  parameters << "Geographic coordinates"
  parameters << "Map references"
  parameters << "Capital" << "Coastline"
  parameters << "Elevation extremes"
  parameters << "Natural hazards" << "Religions"
  parameters << "Population"
  parameters << "Political parties and leaders" << "Electricity - consumption"
  parameters << "Land boundaries"
end

# gets the html content from the website, extracts the individual links to the countries
def getPage(page)
  doc = Nokogiri::HTML(open(page))
  links =  doc.css('li') #countries range from index 2 till 268
  countryList = (118..120) #108-374
  countryList.each do |country|
    m = /\/.*/.match(links[country].css('a')[0]["href"]).to_s
    startOfLink = /.*\-factbook/.match(page).to_s
    countryLink = startOfLink << m
    yield countryLink
  end #do
end

#extract each country related data into an array
def extractInfo(countryPage)
  doc = Nokogiri::HTML(open(countryPage))
  country = Array.new
  oceans = ["Arctic Ocean","Atlantic Ocean","Indian Ocean", "Pacific Ocean", "Southern Ocean"]
  continents = ["Antarctica","Asia","Africa","Australia","Europe","North America", "South America"]
  country << "Country" << doc.css("tr td div.region1 span.region_name1").text
  country.clear if (oceans.include?(country[1]) or continents.include?(country[1]))   
  unless country.empty?
    row = doc.css("tr td div").each do |row|  #entire country page fetched
      country << removeAllKindaSpaces(row)
    end #do
  end #unless
  yield country
end

# removes tab, newline, spaces 
def removeAllKindaSpaces (row)
  removeTab = row.text.gsub /\t/,''
  removeNewline = removeTab.gsub /\n/,''
  removeColon = removeNewline.gsub /\:/,''
  removeColon.strip
end

#return data correspondong to given heading
def getParameter(country,parameter)
  #find required parameters, put values in instance of class Country
  hash = Hash[country.map.with_index.to_a]
  parameterHash = Hash.new
  moreLines = ["Land boundaries", "Political parties and leaders","Religions"]
  #land boundaries is followed by coastline
  #religions is follwed by population
  #political parties is followed by political pressure groups and leaders
  if hash[parameter]
    index = country.index(parameter)
    index +=1
    if moreLines.include?(parameter)
      answer = String.new
      if (parameter=="Land boundaries")
        begin 
          answer << country.at(index) << " "
          index +=1
        end while country.at(index) != "Coastline"
      elsif (parameter=="Religions")
        begin
          answer << country.at(index) << " "
          index +=1
        end while country.at(index) != "Population"
      elsif (parameter=="Political parties and leaders")
        begin
          answer << country.at(index) << " "
          index +=1
        end while country.at(index) != "Political pressure groups and leaders"
      end
      parameterHash[parameter] = answer
    else
      parameterHash[parameter] = country.at(index)
    end
  end
  parameterHash[parameter]
end

main
