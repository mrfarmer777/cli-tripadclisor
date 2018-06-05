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
      scraper.process_destination('/Hotels-g147293-Punta_Cana_La_Altagracia_Province_Dominican_Republic-Hotels.html')
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
    sleep(1)
  end


  def inspiration_view
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
      dest=Theme.all[choice-1]
      puts "You done picked #{dest.name}."
    elsif choice==num_themes+1
      self.main_menu
    end

  end

  def hline
    puts "---------------------------------------------"
  end

end
