# CIT 597 Homework 2 part 1
# submitted by Chaitali Gondhalekar

class RationalNum
  
  include Math
  
  attr_accessor :num, :den

  def initialize(num, den)
    if den==0
      puts "Denominator cannot be zero" 
    else
      @num = num
      @den = den
    end
    if (num < 0 && den < 0 )
      @num = num.abs
      @den = den.abs
    end
  end
  
  def to_s
    "#{num} / #{den}"
  end
  
  #Add two rational numbers
  def add(r)
    rSum = RationalNum.new(@num * r.den + @den * r.num, @den * r.den)
  end
  
  #Return this minus other
  def subtract(r)
    rDif = RationalNum.new(@num * r.den - @den * r.num, @den * r.den)
  end
  
  #Implement multiplication
  def mul(r)
    rProd = RationalNum.new(@num * r.num, @den * r.den)
  end
  
  #Implement division
  def div(r)
    rDiv = RationalNum.new(@num * r.den, @den * r.num)
  end
  
  #Implement squaring of the rational
  def sqr
    rSqur = self.mul(self)
  end
  
  #Cancel out common factors between numerator and denominator.
  def reduceToLowestForm
    maxPossibleFactor = [@num.abs, @den.abs].min
    i = 2
    while i < maxPossibleFactor + 1
      while ((@num % i == 0) && (@den % i == 0))
        @num = @num/i
        @den = @den/i
      end
      i+=1
    end
    if @num == 0
      @den = 1 
    elsif @den == -1
      @num = @num * -1
      @den = @den * -1
    end
  end
  
	#Implement the float() conversion function.
  # @return Decimal equivalent
  def decimal
    @num / @den
  end  
  
end

def main
	r = RationalNum.new(1, 4)
	r1 = RationalNum.new(1, 4)
	r2 = r.add(r1)
	r2.reduceToLowestForm()
	puts r1
  puts " added to "
  puts r 
  puts " = "
  puts r2
  r3 = RationalNum.new(2, 3)
  r4 = RationalNum.new(3, 2)
  r5 = r3.mul(r4)
  r5.reduceToLowestForm()
  puts r5
  
end


main



