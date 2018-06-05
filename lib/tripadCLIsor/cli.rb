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
    puts "How would you like to search? \n1. Search By City \n2. Inspire Me!"

    #getting user input as an integer
    choice=gets.strip.to_i

    #Handling user input
    #Consider refactoring to re-usable menu function
    case choice
    when 1
      puts "Let's search by city"
    when 2
      self.inspiration_view
    else
      puts "Please enter a valid choice."
    end
  end

  def load_inspiration_themes
    load_start=Time.now
    puts "Loading much info..."
    @scraper.process_inspiration
    Theme.all.each do |theme|
      @scraper.process_theme(theme.page_url)
    end
    load_end=Time.now
    puts "Loaded info about #{Destination.all.length} destinations in #{load_end-load_start} seconds."
    puts "HTML Calls: #{scraper.call_count}"
    sleep(3)
  end


  def inspiration_view
    system "clear" or system "cls"
    puts "Get Inspired"
    self.hline
    Theme.all.each_with_index do |theme,ind|
      puts "#{ind+1}. #{theme.name}"
    end
    puts "#{Theme.all.length+1}. Back to Main Menu"

    choice = gets.split.to_i

  end

  def hline
    puts "---------------------------------------------"
  end

end
