class Hotel
  attr_accessor :best_price, :best_vendor, :other_offers, :destination, :theme, :rating
  attr_reader :name

  @@all=[]

  def initialize(hotel_hash)
    @name=hotel_hash[:name]
    if hotel_hash[:best_price]==""
      @best_price="Unavailable"
      @best_vendor="Unavailable"
    else
      @best_price=hotel_hash[:best_price].gsub("$","").to_i
      @best_vendor=hotel_hash[:best_vendor]
    end
    @other_offers=hotel_hash[:other_offers]
    @rating=(hotel_hash[:rating].to_i)/10.0
    self.save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def add_destination(dest)
    self.destinations<<dest
  end




end
