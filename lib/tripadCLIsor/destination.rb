class Destination
  attr_accessor :page_url, :hotels, :themes
  attr_reader :name

  @@all=[]

  def initialize(dest_hash)
    @name=dest_hash[:name]
    @page_url=dest_hash[:page_url]
    @hotels=[]
    @themes=[]
    self.save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    @@all.select {|dest| dest.name==name}
  end

  def self.find_or_create_by_hash(dest_hash)
    dest=Destination.find_by_name(dest_hash[:name])
    if dest==[]
      dest=Destination.new(dest_hash)
    end
    dest
  end






end
