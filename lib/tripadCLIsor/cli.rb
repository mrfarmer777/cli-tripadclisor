#Adds all 'requires' from the tripadCLIsor file, functions like the environment file
require "./lib/tripadCLIsor.rb"


#adds CLI in the TripadCLIsor namespace
class TripadCLIsor::CLI

  def call

    scraper=Scraper.new   #initializing scraper instance

    #User Greeting
    puts "Welcome to TripadCLIsor\nYour way to find a hotel, in the Command Line\n"
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
      scraper.process_inspiration
    else
      puts "Please enter a valid choice."
    end
  end


end
