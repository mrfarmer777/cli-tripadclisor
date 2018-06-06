class Hotel
  attr_accessor :best_price, :best_vendor, :other_offers, :destination, :theme
  attr_reader :name

  @@all=[]

  def initialize(hotel_hash)
    @name=hotel_hash[:name]
    if hotel_hash[:best_price]==""
      @best_price="Unavailable"
      @best_vendor="Unavailable"
    else
      @best_price=hotel_hash[:best_price]
      @best_vendor=hotel_hash[:best_vendor]
    end
    @other_offers=hotel_hash[:other_offers]
    self.save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def readout
    puts "#{self.name}"
    puts "---------------------------------------------"
    puts "Best Price: #{self.best_price} (from #{self.best_vendor})"
    puts "Other Offers:"
    self.other_offers.each do |offer_arr|
      "\t#{offer_arr[0]}: #{offer_arr[1]}"
    end
  end


end
