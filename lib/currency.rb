class Currency

  include Virtus.model

  property :sign, String
  property :fraction_sign, String
  property :format, String
  property :precision, Integer, default: 2
  property :separator, String, default: '.'
  property :delimiter, String, default: ','

end
