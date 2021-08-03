require "open-uri"
require "nokogiri"
require "byebug"
require_relative "recipe"

class ScrapeallrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    #1. get html
    html = open("https://www.allrecipes.com/search/results/?search=#{@ingredient}").read
    #2. parse HTML
    results = []
    doc = Nokogiri::HTML(html,nil, "utf-8")
    doc.search(".card__detailsContainer").first(5).each do |card|
      name = card.search(".card__title").text.strip
      description = card.search(".card__summary").text.strip
      #get the url from the search website
       url = doc.search(".card__titleLink").attribute("href").value

      #prep_time
      prep_time = scrape_prep_time(url)
      results << Recipe.new(name: name,description: description, prep_time: prep_time)
    end
    results
  end

  def scrape_prep_time(url)
    #1. get html
    html = open(url).read
    #2. parse HTML
    doc = Nokogiri::HTML(html,nil, "utf-8")
    doc.search(".recipe-meta-item-body").first.text.strip
  end






end
