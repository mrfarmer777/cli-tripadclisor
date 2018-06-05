#main scraper class for scraping appropriate page of TripAdvisor
require 'pry'
require 'nokogiri'
require 'open-uri'

#NOTES
#by convention, urls will include a / when they are further extensible



class Scraper

  attr_accessor :target_url
  attr_reader :base_url

  def initialize
    @base_url="https://www.tripadvisor.com/"
  end

  def get_node_list(url)
    #returns a Nokogirl nodelist object that can be parsed by apprpriate function
    @target_url=url
    html=open(url)
    doc=Nokogiri::HTML(html)
  end

  def process_inspiration
    #returns an array  of inspiration theme hashes that includes theme title, theme url, example destinations
    doc=get_node_list("#{@base_url}inspiration") #get the nodelist
    themes=doc.css(".shelf_container")
    theme_array=[]
    themes.each do |theme| #build a hash for each theme

      title=theme.css('.title_text').text #gets the inspiration theme title
      page_url=theme.css('.title_text').attribute('href').text #gets the url extension for further scraping

      ex_dest_divs=theme.css('.shelf_item_container>div')  #gets the immediate child divs of shelf_item_container
      destinations=[]  #initializes empty array to hold the theme hashes we 'bout to create
      ex_dest_divs.each do |dest_div|  #build and array of example desintations for the theme
        dest=dest_div.css('.name').text
        destinations<<dest
      end
      theme_hash={title:title, page_url:page_url, destinations:destinations}
      binding.pry
      theme_array<<theme_hash
    end




    #Element selectors
    #inspiration theme containers: ".shelf_container"
    #inspiration titles: .title_text (get the text)
    #inspiration links: .ui_link .title_text (get the href attribute text)
    #insp destination container: .shelf_item_container>div (holds pictures of each destination within)
    #destination title:


  end






end
