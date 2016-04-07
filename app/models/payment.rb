class Payment
  attr_reader :total_payment, :round_payment

  def initialize(option)
    @option = option.to_i
  end

  def a(round_completed_essay:, total_completed_essay: )
    multiplier = case @option
    when 1
      0.625
    when 2
      1.54
    when 3
      1.64
    else
      raise InvalidOption
    end
    @total_payment = multiplier * total_completed_essay
    @round_payment = multiplier * round_completed_essay
    self
  end

  def c(total_responses: , responses_from_round:)
    multiplier = case @option
    when 1
      0.20
    when 2
      0.56
    when 3
      0.56
    else
      raise InvalidOption
    end

    @total_payment = total_responses * multiplier
    @round_payment = responses_from_round * multiplier
    self
  end

  def f
    @total_payment = case @option
    when 1
      25
    when 2
      24.64
    when 3
      24.64
    else
      raise InvalidOption
    end
    @round_payment = 0
    self
  end

  class InvalidOption < StandardError; end
end