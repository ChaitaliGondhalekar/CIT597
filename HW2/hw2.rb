require 'nokogiri'
require 'open-uri'

page = "https://www.cia.gov/library/publications/the-world-factbook/print/textversion.html"

doc = Nokogiri::HTML(open(page))

# doc.css('li')[1]['href'].each do |row|
#   p "using css, li, href"
#   p row.content
# end

# doc.xpath('//body/div/div[1]/section/div[last()]/div[last()]/article/div[1]/div[1]/table/tr[2]/td/div/form/select/option[3]').each do |node|
#   p "using xpath!"
#   puts
#   puts node
# end


#entire link , working
links =  doc.css('li') #countries range from index 2 till 268
puts
p "using css, specific li"
puts
countryList = (108..374)
countryList.each do |country|
  # puts links[country].css('a')[0]["href"] #link to each country [2..-1]
  m = /\/.*/.match(links[country].css('a')[0]["href"]).to_s
  startOfLink = /.*\-factbook/.match(page).to_s
  countryLink = startOfLink << m
  # puts countryLink
end




  




