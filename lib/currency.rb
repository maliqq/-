class Currency

  include Virtus.model

  attribute :sign, String
  attribute :fraction_sign, String
  attribute :format, String
  attribute :precision, Integer, default: 2
  attribute :separator, String, default: '.'
  attribute :delimiter, String, default: ','

end
