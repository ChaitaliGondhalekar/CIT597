require 'nokogiri'
require 'open-uri'

# calls other methods
def main
  countryArray = getPage()
  getParameters(countryArray)
end

# gets the html content from the website, extracts the individual links to the cou
def getPage
  page = "https://www.cia.gov/library/publications/the-world-factbook/print/textversion.html"

  doc = Nokogiri::HTML(open(page))

  #entire link , working
  links =  doc.css('li') #countries range from index 2 till 268
  puts
  p "using css, specific li"
  puts
  countryList = (108..374) #374
  countryList.each do |country|
    # puts links[country].css('a')[0]["href"] #link to each country [2..-1]
    m = /\/.*/.match(links[country].css('a')[0]["href"]).to_s
    startOfLink = /.*\-factbook/.match(page).to_s
    countryLink = startOfLink << m
    # puts countryLink
    #give conutryLink to getParameters
    extractInfo(countryLink)
  end
end

def extractInfo(countryPage)
  puts
  doc = Nokogiri::HTML(open(countryPage))
  #country name
  title  = doc.css("tr td div.region1 span.region_name1").text
  # yield |title|
  p title
  country = Array.new()
  row = doc.css("tr td div").each do |row|
    # p "classification"
   #  heading = row.css("div.category")
   #  p heading.text
   #  puts
   #  p "data"
   #  data = row.css("div.category_data")
   #  p data.to_s
   
    # p "text"
    # p row.text
    removeTab = row.text.gsub /\t/,''
    removeNewline = removeTab.gsub /\n/,''
    country << removeNewline.squeeze(" ")
    # p "href"
    #p row["href"]
    #  p "tr"
 # p row.css("tr").text
 #    p "title"
 # p row['title']
    # puts
  end
  # body/div id="countryInfo"[0]/div id = "CollapsiblePanel1_Geo"/div class="wrapper"/..
  # ../div class ="answer"
  # puts country
  getParameters(country)
end

def getParameters(country)
  #find required parameters, put values in instance of class Country
  # unless country.includes("Geographic coordinates:")? puts country.index("Geographic coordinates:")
  hash = Hash[country.map.with_index.to_a]    # => {"a"=>0, "b"=>1, "c"=>2}
  # puts "index"
  puts hash.to_s
  #country name, go till :: and take the rest
  puts country.at
  #co-ordinates
  puts country.at(hash[" Geographic coordinates: "] + 1 )
  puts country.at(hash[" Map references: "] + 1)
  if hash[" Capital: "] 
    puts country.at(hash[" Capital: "] + 1)
  end
  puts country.at(hash[" Coastline: "] + 1)
  puts country.at(hash[" Geography - note: "] + 1)
  if hash[" Elevation extremes: "]
    puts country.at(hash[" Elevation extremes: "] + 1)
    puts country.at(hash[" Elevation extremes: "] + 1 +1)
  end
  if hash[" Natural hazards: "]
    puts country.at(hash[" Natural hazards: "] + 1)
  end
  if hash[" Religions: "]
    puts country.at(hash[" Religions: "] + 1)
  end
  puts

  puts country.at(hash[" Population: "] + 1)
  puts country.at(hash[" Country name: "] + 1)
  puts country.at(hash[" Country name: "] + 2)
  if hash[" Political parties and leaders: "]
    puts country.at(hash[" Political parties and leaders: "] + 1)
  end
  if hash[" Electricity - consumption: "]
    puts country.at(hash[" Electricity - consumption: "] + 1)
  end
  
end

def getAnswers
  
end

getPage

  
#wild card - no water or all surrounding waters
#attend independance day celebrations ?
#longest railroad length in some continent


