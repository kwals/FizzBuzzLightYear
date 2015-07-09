require 'pry'
require 'Prime'
require 'minitest/autorun'

class Fuzz
  def lowest_common_multiple (n1, n2)
    factors_of_lcm = []
    n2_factors = prime_factors(n2)
    prime_factors(n1).each do |factor|
      if n2_factors.include? factor
        n2_factors.delete_at(n2_factors.find_index(factor))
      end
      factors_of_lcm.push(factor)
    end
    n2_factors.each {|left_over_factor| factors_of_lcm.push(left_over_factor) }
    factors_of_lcm.inject(1){|memo, factor| memo *= factor}
  end

  def prime_factors(n)
    prime_factors = []
    Prime.each(n) do |prime|
      if n % prime == 0
        prime_factors.push(prime)
        n /= prime
      end
    end
    prime_factors.push(n) unless n == 1
    return prime_factors
  end

  def fizzbuzz (top_number=15,fizz=3,buzz=5)
    answer_array = []
    if (fizz.is_a?(Fixnum)) && (buzz.is_a?(Fixnum))
      1.upto(top_number) do |n|
        if n % lowest_common_multiple(fizz,buzz) == 0
          answer_array << "FizzBuzz"
        elsif n % buzz == 0
          answer_array << "Buzz"
        elsif n % fizz == 0
          answer_array << "Fizz"
        else
          answer_array << n
        end
      end
    end
    return answer_array
  end

end


class FizzyBuzzyTest < MiniTest::Test

  def test_fizz_buzz_works
  end 

  def test_prime_factors
    f = Fuzz.new
    assert f.prime_factors(10).include?(5)
    assert f.prime_factors(10).include?(2)

    refute f.prime_factors(10).include?(3)
    refute f.prime_factors(10).include?(1)

  end

  def test_lcm_can_check_easy_numbers
    f = Fuzz.new
    assert_equal f.lowest_common_multiple(3,6), 6
    assert_equal f.lowest_common_multiple(6,3), 6
    assert_equal f.lowest_common_multiple(5,10), 10
  end

  def test_fizzbuzz
    f = Fuzz.new
    assert_equal f.fizzbuzz(5), [1, 2,"Fizz", 4, "Buzz"]
  end


end
