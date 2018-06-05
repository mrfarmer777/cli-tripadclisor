#Adds all 'requires' from the tripadCLIsor file, functions like the environment file
require "./lib/tripadCLIsor.rb"


#adds CLI in the TripadCLIsor namespace
class TripadCLIsor::CLI

  attr_accessor :scraper

  def call

    @scraper=Scraper.new   #initializing scraper instance


    #User Greeting
    puts "Welcome to TripadCLIsor\nYour way to find a hotel, in the Command Line\n"

    #consider doing the scraping, processing, and setting up here, then allow user to do some stuff
    #scraper.process_inspiration #while we're reading....
    #test_theme_url=Theme.all[0].page_url
    #scraper.process_theme(test_theme_url)
    self.load_inspiration_themes
    puts "How would you like to search? \n1. Search By City \n2. Inspire Me!"

    #getting user input as an integer
    choice=gets.strip.to_i

    #Handling user input
    #Consider refactoring to re-usable menu function
    case choice
    when 1
      puts "Let's search by city"
    when 2
      puts "Let's get inspired"
      Theme.readout
    else
      puts "Please enter a valid choice."
    end
  end

  def load_inspiration_themes
    puts "Let's get scrapin... #{Time.now}"
    @scraper.process_inspiration
    Theme.all.each do |theme|
      @scraper.process_theme(theme.page_url)
    end
    puts "we done scrapin. #{Time.now}"
  end


end
