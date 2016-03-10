require 'minitest/autorun'

require 'virtus-money'

class TestMoney < Minitest::Test
  attr_reader :usd

  def test_equal
    assert_equal Money.new(100, :USD), Money.new(100, :USD)
    assert_equal Money.new(0, :USD), Money.new(0, :GBP)

    assert Money.new(100, :USD) != Money.new(100, :GBP)
    assert Money.new(99, :USD) != Money.new(100, :USD)
  end

  def test_unary
    amount = Money.new(100, :USD)
    assert_equal -amount, Money.new(-100, :USD)
    assert_equal +amount, Money.new(100, :USD)

    amount = Money.new(-100, :USD)
    assert_equal -amount, Money.new(100, :USD)
    assert_equal +amount, Money.new(-100, :USD)
  end
end
