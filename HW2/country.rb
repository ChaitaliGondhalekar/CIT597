#basic class to store country information
class Country
  
    attr_accessor :name, :paraList, :paraHash

    def initialize(name, paraList)
        @name = name
        @paraList = paraList
        @paraHash = Hash[*@paraList]
    end

    def to_s
        "Country : #{@name} ParaList: #{@paraList}"
    end
end
