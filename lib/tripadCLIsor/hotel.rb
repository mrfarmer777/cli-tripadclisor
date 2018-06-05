class Hotel
  attr_accessor :best_price, :best_vendor, :other_offers, :destination, :theme
  attr_reader :name

  @@all=[]

  def initialize(hotel_hash)
    @name=hotel_hash[:name]
    @best_price=hotel_hash[:best_price]
    @best_vendor=hotel_hash[:best_vendor]
    @other_offers=hotel_hash[:other_offers]
    self.save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

end
