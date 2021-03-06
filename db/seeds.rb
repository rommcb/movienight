# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "nokogiri"
require "date"


user_1 = User.create!({username: "Frederic",email:'fred@fred.fred', password:'123123'})
user_2 = User.create!({username: "Pierre", email:'pierre@pierre.pierre', password:'123123'})
user_3 = User.create!({username: "Romain", email:'romain.borremans@gmail.com', password:'123123'})
user_4 = User.create!({username: "Joseph", email:'joseph@joseph.joseph', password:'123123'})
user_5 = User.create!({username: "Bob", email:'bob@bob.bob', password:'123123'})


def scrape(start)
  if start > 300
    return 0
  end

  url = "https://www.imdb.com/search/title/?groups=top_1000&sort=user_rating,desc&count=100&start=#{start}&ref_=adv_nxt"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  arr = []
  html_doc.search(".mode-advanced").each do |element_1|
    immage = element_1.search(".float-left").search("img").first.attributes["loadlate"].value
    element = element_1.search(".lister-item-content")
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
    url = "https://api.themoviedb.org/3/search/movie?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&query=#{name.encode('ASCII', 'binary', invalid: :replace, undef: :replace, replace: '')}"
    res = JSON.parse(open(url).read)
    if (res["results"].length != 0 && res["results"][0]['poster_path'] != nil)
      poster = "http://image.tmdb.org/t/p/w500/#{res["results"][0]['poster_path']}"
      dir = Director.where(fullname: director)

      if dir.length == 0
        dir = Director.create!({fullname: director})
      else
        dir = dir[0]
      end
      mov = Movie.where(title: name)
      if mov.length == 0
        mov = Movie.create!({director_id: dir.id, title: name, synopsis: description, duration: duration, cover:immage, poster:poster})
        mov.poster = poster
      else
        mov = mov[0]
      end
      genres.each do |genre|
        if Genre.where(name: genre).length == 0
          gen = Genre.create!({name: genre})
          GenresAttribution.create!({movie_id: mov.id, genre_id: gen.id})
        else
          GenresAttribution.create!({movie_id: mov.id, genre_id: Genre.where(name: genre)[0].id})
        end
        
      end

      cast.each do |actor|
        if Actor.where(fullname: actor).length == 0
          act =Actor.create!({fullname: actor})
          Casting.create!({movie_id: mov.id, actor_id: act.id})
        else
          Casting.create!({movie_id: mov.id, actor_id: Actor.where(fullname: actor)[0].id})
        end
      end
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

# event_1 = Event.create!({name:"first", date_start: DateTime.now, date_end: Date.new(2020,12,12), code: "123123", where:"In my house bitches!"})
# event_3 = Event.create!({name:"second", date_start: DateTime.now, date_end: Date.new(2020,12,12), code: "123124", where:"In the garage!"})

# EventSubscription.create!({owner: true, user_id:1, event_id:1})
# EventSubscription.create!({owner: false, user_id:2, event_id:1})
# EventSubscription.create!({owner: false, user_id:3, event_id:1})
# EventSubscription.create!({owner: false, user_id:4, event_id:1})

# EventSubscription.create!({owner: true, user_id:1, event_id:2})
# EventSubscription.create!({owner: false, user_id:2, event_id:2})

# EventMovie.create!({movie_id:1, event_id:1, score:1})
# EventMovie.create!({movie_id:2, event_id:1, score:1})
# EventMovie.create!({movie_id:3, event_id:1, score:1})
# EventMovie.create!({movie_id:4, event_id:1, score:1})
# EventMovie.create!({movie_id:5, event_id:1, score:0})
# EventMovie.create!({movie_id:6, event_id:1, score:0})
# EventMovie.create!({movie_id:7, event_id:1, score:0})

# EventMovie.create!({movie_id:2, event_id:2, score:0})
# EventMovie.create!({movie_id:6, event_id:2, score:0})
# EventMovie.create!({movie_id:7, event_id:2, score:0})

# Review.create!({user_id:1, event_movie_id:1})
# Review.create!({user_id:2, event_movie_id:2})
# Review.create!({user_id:2, event_movie_id:3})

# Review.create!({user_id:1, event_movie_id:8})
# Review.create!({user_id:1, event_movie_id:9})
# Review.create!({user_id:2, event_movie_id:10})

# Review.create!({user_id:3, event_movie_id:4})
