# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "nokogiri"

def scrape(start)
  if start > 901
    return 0
  end

  url = "https://www.imdb.com/search/title/?groups=top_1000&sort=user_rating,desc&count=10&start=#{start}&ref_=adv_nxt"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  arr = []
  html_doc.search(".lister-item-content").each do |element|
    name = element.search(".lister-item-header").at("a").text
    duration = element.search(".text-muted").search(".runtime").text.delete_suffix!(' min').to_i
    genres = []
    element.search(".text-muted").search(".genre").text[1..].gsub(" ","").split(",").each do |g|
      genres.push(g)
    end
    date = element.search(".text-muted").text[1..4]
    description =  element.search(".text-muted")[2].text[5..]
    director = ""
    if element.search('p')[2].children[0].text[5..12] == "Director"
      director = element.search('p')[2].children[1].text
    end
    cast = []
    element.search('p')[2].children.search("a")[1..].each do |item|
      cast.push(item.text)
    end

    dir = Director.create!({fullname: director})
    genres.each do |genre|
      Genre.create!({name: genre})
    end
    cast.each do |actor|
      Actor.create!({fullname: actor})
    end

    Movie.create!({director: dir, title: name, synopsis: description})
    # name
    # duration
    # director
    # description
    # genres
    # cast
  end
  scrape(start + 100)
end

