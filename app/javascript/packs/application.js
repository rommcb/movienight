// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { events } from './autocomplete';
import { act_event } from './autocomplete';
import {movie} from './autocomplete';
import {review} from './autocomplete';
import {poster} from './autocomplete';


document.addEventListener('turbolinks:load', () => {

  const user = document.getElementById('user_id')
  if (user != null){
    let user_id_start = user.innerHTML
    const event = document.getElementById('event_id')
    if (event != null){
      let event_id_start = event.innerHTML
      movie(user_id_start, event_id_start)
    }
  } 
  
  // Call your functions here, e.g:
  // initSelect2();
  const genre = document.getElementById("genre_pref")
  if(genre != null){
    events('genre', genre)
  }

  const actor = document.getElementById("actor_pref")
  if(actor != null){
    events('actor', actor)
  }

  const director = document.getElementById("director_pref")
  if(director != null){
    events('director', director)
  }

  const react = document.getElementById("reactivate")
  if(react != null){
    react.addEventListener('click', (e) => { act_event(react, e) }, false);
  }

  const likebtn = document.getElementById("donotlikebtn")
  likebtn.addEventListener("click", function(item){
    item.preventDefault();
    const like_event = document.getElementById("movie_name");
    const like_event1= document.getElementById("img_swipe");
    like_event.classList.add("slide-in-left");
    like_event1.classList.add("slide-in-left");

    const user_id = document.getElementById('user_id').innerHTML
    const event_id = document.getElementById('event_id').innerHTML
    const event_movie_id = document.getElementById('event_movie_id').innerHTML
    review(user_id, event_movie_id, 0)
    setTimeout(function(){
      like_event.classList.remove("slide-in-left");
      like_event1.classList.remove("slide-in-left");
      }, 600);
    console.log(user_id);
    movie(user_id, event_id)
  });
  
  const donotlikebtn = document.getElementById("likebtn")
  donotlikebtn.addEventListener("click", function(item){
    item.preventDefault();
    const like_event2 = document.getElementById("movie_name");
    const like_event3 = document.getElementById("img_swipe");
    like_event2.classList.add("slide-in-right");
    like_event3.classList.add("slide-in-right");

    const user_id = document.getElementById('user_id').innerHTML
    const event_id = document.getElementById('event_id').innerHTML
    const event_movie_id = document.getElementById('event_movie_id').innerHTML
    review(user_id, event_movie_id, 0)
    setTimeout(function(){
      like_event2.classList.remove("slide-in-right");
      like_event3.classList.remove("slide-in-right");
      }, 600);
    
    console.log(user_id);
    movie(user_id, event_id)
  });
  
  document.addEventListener('keyup', function(event) {
    const code = event.keyCode
    if (code == '37') {
        // Left
        let dntlkbtn = document.getElementById("donotlikebtn")
        if (dntlkbtn != null){
          document.getElementById("donotlikebtn").click();
        }
      
      
    }
      else if (code == '39') {
        // Right
        let lkbtn = document.getElementById("likebtn")
        if (lkbtn != null) {
          document.getElementById("likebtn").click();
        }
        
    }
  })
});
