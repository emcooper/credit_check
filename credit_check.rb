card_number = "4929735477250543"

class LuhnValidator
  attr_reader :card_number, :valid

  def initialize(card_number, valid = false)
    @card_number = card_number
    @valid = valid
  end

  def validate
    is_valid?
    print_results
  end

  def separate_digits
    separated_digits = @card_number.chars
    separated_digits.each_index do |index|
      separated_digits[index] = separated_digits[index].to_i
    end
    separated_digits
  end

  def double_alternating_values
    doubled = []
    separate_digits.each_index do |index|
      if (separate_digits.length - index).even? #digits.index still is 1 on third pass. why? b/c it finds the index of the first time that value appears, so repeated values will be messed up
        doubled << separate_digits[index] * 2
      else
        doubled << separate_digits[index]
      end
    end
    doubled
  end

  def sum_2_digit_values
    doubled_and_summed = []
    double_alternating_values.each do |number|
      if number >= 10
        doubled_and_summed << (number - 10) + 1
      else
        doubled_and_summed << number
      end
    end
    doubled_and_summed
  end

  def sum_results
    results_summed = 0
    sum_2_digit_values.each do |number|
      results_summed += number
    end
    results_summed
  end

  def is_valid?
    if sum_results % 10 == 0
      @valid = true
    end
  end

  def print_results
    if @valid == true
      puts "The number is valid!"
    else
      puts "The number is invalid!"
    end
  end
end

luhnvalidator_1 = LuhnValidator.new(card_number)
luhnvalidator_1.validate
