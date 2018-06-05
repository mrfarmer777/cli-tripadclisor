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
    #returns a hash of inspiration themes
    doc=get_node_list("#{@base_url}inspiration")
    binding.pry
    themes=doc.css(".shelf_container")


    #Element selectors
    #inspiration theme containers: ".shelf_container"
    #inspiration titles: .ui_link .title_text (get the text)
    #inspiration links: .ui_link .title_text (get the href attribute text)
    #insp destination container: .shelf_item_container>div (holds pictures of each destination within)
    #destination title:


  end






end
