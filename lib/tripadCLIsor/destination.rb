class Destination
  attr_accessor :page_url, :hotels
  attr_reader :name

  @@all=[]

  def initialize(dest_hash)
    @name=dest_hash[:name]
    @page_url=dest_hash[:page_url]
    @hotels=[]
    self.save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end



end
