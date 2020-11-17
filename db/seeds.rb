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

  url = "https://www.imdb.com/search/title/?groups=top_1000&sort=user_rating,desc&count=100&start=#{start}&ref_=adv_nxt"
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


    dir = Director.where(fullname: director)

    if dir.length == 0
      dir = Director.create!({fullname: director})
    else
      dir = dir[0]
    end

    mov = Movie.where(title: name)
    if mov.length == 0
      pp "here"
      pp dir
      mov = Movie.create!({director_id: dir.id, title: name, synopsis: description, duration: duration})
    else
      mov = mov[0]
    end
    pp mov
    genres.each do |genre|
      if Genre.where(name: genre).length == 0
        gen = Genre.create!({name: genre})
        GenresAttribution.create!({movie_id: mov.id, genre_id: gen.id})
      end
      GenresAttribution.create!({movie_id: mov.id, genre_id: Genre.where(name: genre)[0].id})
    end

    cast.each do |actor|
      if Actor.where(fullname: actor).length == 0
        act =Actor.create!({fullname: actor})
        Casting.create!({movie_id: mov.id, actor_id: act.id})
      end
      Casting.create!({movie_id: mov.id, actor_id: Actor.where(fullname: actor)[0].id})
    end
    # name
    # duration
    # director
    # description
    # genres
    # cast
  end
  scrape(start + 100)
end

scrape(1)

