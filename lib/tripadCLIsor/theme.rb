require 'pry'

class Theme
  attr_accessor :title, :destinations, :page_url, :ex_dest

  @@all=[]

  def initialize(theme_hash)
    #decided to take in a hash here made by the scraper, reduce dependencies on nokogiri, keeps html away from this object. Best practice?
    @title=theme_hash[:title]
    @page_url=theme_hash[:page_url]
    @ex_dest=theme_hash[:ex_dest]
    self.save #adds theme instance to class variable @@all
  end

  def self.all
    @@all
  end

  def save
    @@all<<self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.readout
    @@all.each do |theme|
      puts "#{theme.title} - Example Destinations: #{theme.ex_dest}, Page Url: #{theme.page_url}"
    end
  end

  def readout
    puts "#{self.name}"
  end

  #need a search by name method
  def self.find_by_name(name)
    sel_theme=@@all.detect {|theme| theme.title==name}
  end


  #need a method for adding the rest of the destinations to the theme, not just strings





end
