class Money < Struct.new(:value, :currency)

  class << self
    def from(value)
      case value
      when BigDecimal
      when Float
      when Integer
      when String
      end
    end

    def wrap(value, currency)
      if value.is_a?(Money)
        raise ArgumentError unless value.currency == currency
        value
      else
        new(value, currency)
      end
    end
  end

  def eql?(other)
    other.is_a?(Money) && other.value == value && (value == 0 || other.currency == currency)
  end

  def <=>(other)
    wrap_value(other) <=> value
  end

  delegate :zero?, :nonzero?, to: :value
  delegate :abs, :-, :+, to: :converted_value

  class ConvertedValue < BasicObject
    def initialize(money)
      @money = money
    end

    def method_missing(method, *args, &block)
      new_value = money.value.send(method, *args, &block)
      money.wrap(new_value)
    end
  end

  def +(other)
    wrap(value + wrap_value(other))
  end

  def /(other)
    wrap(value / wrap_value(other))
  end

  alias_method :div, :/

  def to_s
  end

  def divmod(other)
    other = wrap_value(other)
    q, remainder = value.divmod(other)
    [q, wrap(remainder)]
  end

  def denominator(other)
    divmod(other)[0]
  end

  def %(other)
    divmod(other)[1]
  end
  alias_method :modulo, :%

  alias_method :to_int, :value

  protected

    def wrap(new_value)
      self.class.wrap(new_value, currency)
    end

    def wrap_value(some_value)
      if some_value.is_a?(Money)
        raise ArgumentError unless some_value.currency == currency
        some_value.value
      else
        Money.wrap_numeric(some_value)
      end
    end

end
