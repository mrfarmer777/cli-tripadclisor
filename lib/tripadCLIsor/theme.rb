require 'pry'

class Theme
  attr_accessor :title, :destinations, :page_url, :ex_destinations

  @@all=[]

  def initialize(theme_div)
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





end
