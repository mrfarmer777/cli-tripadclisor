#Adds all 'requires' from the tripadCLIsor file, functions like the environment file
require "./lib/tripadCLIsor.rb"


#adds CLI in the TripadCLIsor namespace
class TripadCLIsor::CLI

  attr_accessor :scraper

  def call

    @scraper=Scraper.new   #initializing scraper instance
    system "clear" or system "cls"
    self.load_inspiration_themes
    self.main_menu
  end

  def main_menu
    system "clear" or system "cls"

    #User Greeting
    puts "Welcome to TripadCLIsor\nYour way to find a hotel, in the Command Line\n"
    self.hline
    #scrapes all themes and instantiates their destinations
    puts "How would you like to search? \n1. Selected Destinations \n2. Themed Excursions"

    #getting user input as an integer
    choice=gets.strip.to_i

    #Handling user input
    #Consider refactoring to re-usable menu function
    case choice
    when 1
      self.rand_dest_view
    when 2
      self.all_themes_view
    when 3
      scraper.process_destination('/Hotels-g147293-Punta_Cana_La_Altagracia_Province_Dominican_Republic-Hotels.html')
    else
      puts "Please enter a valid choice."
    end
  end

  def load_inspiration_themes
    load_start=Time.now
    puts "Loading much info..."
    @scraper.populate_themes
    Theme.all.each do |theme|
      @scraper.populate_destinations(theme)
    end
    load_end=Time.now
    puts "Loaded info about #{Destination.all.length} destinations in #{load_end-load_start} seconds."
    puts "HTML Calls: #{scraper.call_count}"
    sleep(3)
  end


  def all_themes_view
    system "clear" or system "cls"
    puts "Get Inspired"
    self.hline
    num_themes=Theme.all.length
    Theme.all.each_with_index do |theme,ind|
      puts "#{ind+1}. #{theme.title}"
    end
    puts "#{num_themes+1}. Back to Main Menu"

    choice = gets.strip.to_i

    if choice.between?(1,num_themes)
      theme=Theme.all[choice-1]
      self.theme_view(theme)
    elsif choice==num_themes+1
      self.main_menu
    end

  end

  def hline
    puts "---------------------------------------------"
  end

  def rand_dest_view
    system "clear" or system "cls"
    puts "Search Selected Destinations"
    self.hline
    num_dest=14
    sel_cities=Destination.all.sample(14)
    sel_cities.each_with_index do |dest,ind|
      puts "#{ind+1}. #{dest.name}"
    end
    self.hline
    puts "#{num_dest+1}. Select new destinations..."
    puts "#{num_dest+2}. Back to Main Menu..."

    choice = gets.strip.to_i

    if choice.between?(1,num_dest)
      dest=sel_cities[choice-1]
      puts "You done picked #{dest.name}."
    elsif choice==num_dest+1
      self.city_view
    elsif choice==num_dest+2
      self.main_menu
    end

  end

def theme_view(theme)
  system "clear" or system "cls"
  puts "Showing Destinations for '#{theme.title}' "
  self.hline
  num_items=theme.destinations.length
  theme.destination.each_with_index do |dest,ind|
    puts "#{ind+1}. #{dest.name} - #{dest.hotels.length} Hotels"
  end
  puts "#{num_items+1}. Back to Main Menu"

  choice = gets.strip.to_i

  if choice.between?(1,num_items)
    dest=Theme.all[choice-1]
    #scraper.populate_hotels
  elsif choice==num_items+1
    self.main_menu
  end



end
