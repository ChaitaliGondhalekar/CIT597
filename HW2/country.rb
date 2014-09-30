#basic class to store country information
class Country
  #Q1 continent Map refernces under Geo ,earthquakeProne Natural Hazards under Geography? 
  #extra credit capital under Government
  #Q2 elevationPoint=lowest one given=Elvation Extremes under Geography, 
  #Q3, extra credit longitude, altitude, SE under Geo Geographic Co-ordinates
  #Q7 landlocked=zero coastline
  #Q4 politicalParties=given[leaders] under Government, 
  #Q5 elecCons = Electricity-Consumption under Energy
  #population=given parameter, under People and Society
  #Q6 domRel, allRels,  =Religions under People and Society
  #Q8 wildcard, a water body completely surrounded by the country
  
    attr_accessor :continent, :earthquakeProne, :capital, :elevation, :coordinates, :landlocked, 
    :politicalParties, :elecCons, :population, :domRel, :allRels

    def initialize(name, options)
        self.name = name
        self.earthquakeProne = options[:earthquakeProne]
        self.capital = options[:capital]
        self.elevation = options[:elevation]
        self.coordinates = options[:coordinates]
        self.landlocked = options[:landlocked]
        self.politicalParties = options[:politicalParties]
        self.elecCons = options[:elecCons]
        self.population = options[:population]
        self.domRel = options[:domRel]
        self.allRels = options[:allRels]
    end

    def to_s
        "#{self.name} EarthquakeProne: #{self.earthquakeProne}, Capital:(#{self.capital}), elevation: #{self.elevation}, coordinates: #{self.coordinates}, lanlocked: #{self.landlocked},
        Political Parties: #{self.politicalParties}, Electricity Consumption: #{elecCons}, Population: #{self.population},
        Dominent Religion: #{self.domRel}, All Religions: #{self.allRels}"
    end

end

