#main scraper class for scraping appropriate page of TripAdvisor
require 'pry'
require 'nokogiri'
require 'open-uri'

#NOTES
#by convention, url extensions will include slash as first character, that's how they're stored by Tripadvisor



class Scraper

  attr_accessor :target_url, :call_count #as yet, unused
  attr_reader :base_url

  def initialize
    @base_url="https://www.tripadvisor.com"
    @call_count=0
  end

  #All-purpose scraping method for getting the Nokogiri Node List
  def get_node_list(url)

    html=open(url)
    @call_count+=1
    doc=Nokogiri::HTML(html)
  end


  #Scrapes the inspiration page and create new hashes that are passed to the Theme.new method
  def process_inspiration
    doc=get_node_list("#{@base_url}/inspiration") #get the nodelist
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


  #Scrapes a theme page and creates new destinations for all those found on the theme page
  def process_theme(theme_url)
    target_url="#{@base_url}#{theme_url}"
    doc = get_node_list(target_url)
    #find the appropriate theme, get it here so it can be added to
    theme_name=doc.css('.ui_header')
    sel_theme = Theme.find_by_name(theme_name)


    dest_divs=doc.css('.ui_poi_thumbnail')
    dest_divs.each do |dest|
      name=dest.css('.name').text
      page_url=dest.attribute('href').text
      dest_hash={name: name, page_url: page_url}
      Destination.new(dest_hash)
    end
    #title selector: .ui_header (text)
    #destination info container: .ui_poi_thumbnail (whole div)
    #distination link: (href attribute for the destination div)
    #dest name: .name (within the container) text
  end

  def process_destination(dest_url)
    title_url="#{@base_url}#{dest_url}"
    doc=get_node_list(title_url)

    hotel_cards=doc.css('.main_col')
    hotel_cards.each do |hotel|
      name=hotel.css('.property_title').text
      best_vendor=hotel.css('.price_wrap>.provider').text
      best_price=hotel.css('.price_wrap>.price').text
      offer_list=hotel.css('.text-links>.text-link')
      other_offers=[]
      offer_list.each do |offer|
        vendor=offer.css('.vendor').text
        price=offer.css('.price').text
        offer_data=[vendor,price]
        other_offers<<offer_data
      end


    #hotel info card: .main_col
    #hotel name: .property_title
    #best price: .price .__resizeWatch
    #other prices: .text-links
    #single price: .text-link
    #Vendor: .vendor (within single price)
    #price: .price (within single price)







end
