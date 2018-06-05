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


  #Process the inspiration page and create new hashes that are passed to the Theme.new method
  def process_inspiration
    doc=get_node_list("#{@base_url}inspiration") #get the nodelist
    themes=doc.css(".shelf_container")

    themes.each do |theme| #build a hash for each theme, use it create an instance of Theme class
      title=theme.css('.title_text').text #gets the inspiration theme title
      page_url=theme.css('.title_text').attribute('href').text #gets the url extension for further scraping
      ex_dest_divs=theme.css('.shelf_item_container>div')  #gets the immediate child divs of shelf_item_container
      destinations=[]  #initializes empty array to hold the theme hashes we 'bout to create
      ex_dest_divs.each do |dest_div|  #build and array of example desintations for the theme
        dest=dest_div.css('.name').text
        destinations<<dest
      end
      theme_hash={title:title, page_url:page_url, ex_dest:destinations}
      Theme.new(theme_hash) #initialize a new Theme instance
      #binding.pry
    end
    #Element selectors
    #inspiration theme containers: ".shelf_container"
    #inspiration titles: .title_text (get the text)
    #inspiration links: .ui_link .title_text (get the href attribute text)
    #insp destination container: .shelf_item_container>div (holds pictures of each destination within)
    #destination title:

  end

  def process_theme(theme_url)
    target_url="#{@base_url}#{theme_url}"
    doc = get_node_list(target_url)
    #find the appropriate theme, get it here so it can be added to


  end






end
