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
// ----------------------------------------------------d

// External imports
import "bootstrap";

// Internal imports, e.g:
import { events } from './autocomplete';
import { act_event } from './autocomplete';
import { movie } from './swipe';
import { dislike } from './swipe';
import { like } from './swipe';
import { dragElement } from './swipe';
import { myMoveLike } from './swipe';
import { flipCard } from './swipe';
import { smooth } from './swipe'
import { show } from './next'
 

document.addEventListener('turbolinks:load', () => {

  if(document.getElementsByTagName('body')[0].classList.contains("action_index")){
    const array = document.getElementsByClassName('btn-member')
    for (let i = 0; i < array.length; i++) {
      const elem = array[i];
      elem.addEventListener("click", (e) => {
        const code = elem.id
        document.getElementById("code-div").innerHTML = `Invite members by sharing your event code: <strong>${code}</strong>`
      },false)
      // $('#myModal').on('shown.bs.modal', function () {
      //   $('#myInput').trigger('focus')
      // })  
    }
  }

  const winner = document.getElementById('winner')
  if(winner != null){
    document.getElementsByClassName('bg-image')[0].style.opacity = 0.0
    document.getElementsByClassName('bg-image')[0].style.backgroundSize = "cover";
    document.getElementsByClassName('bg-image')[0].style.backgroundPosition = "0% 50%";
    document.getElementsByClassName('bg-image')[0].style.backgroundImage =`url('${document.getElementById('winner').src}')`;
    document.getElementById('reveal_btn').addEventListener('click', () => show(), false)
    const wrap = document.querySelector(".wrap");
    const btnWinner = document.getElementById("reveal_btn");
    const btnReset = document.querySelector(".res_button");

    console.log(wrap);
    console.log(btnWinner);
  
    if(btnWinner != null){
        btnWinner.addEventListener("click", () => {
        // wrap.classList.add("hidden");
        setTimeout(function(){
          btnReset.classList.remove("hidden");
        }, 2000)
        
    });
    }
  }
  

  const user = document.getElementById('user_id')
  if (user != null){
    let user_id_start = user.innerHTML
    const event = document.getElementById('event_id')
    if (event != null){
      let event_id_start = event.innerHTML
      document.getElementById('likebtn').style.display = "block"
      document.getElementById('donotlikebtn').style.display = "block"
      
      document.getElementsByClassName('bg-image')[0].style.backgroundSize = "cover";
      document.getElementsByClassName('bg-image')[0].style.backgroundPosition = "0% 50%";
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


  if(document.getElementById('move')) {
    dragElement(document.getElementById('move'))
  }

  let dnt_pushed = false
  const donotlikebtn = document.getElementById("donotlikebtn")
  donotlikebtn.addEventListener("click", (item) => {
    if(dnt_pushed == true){
      return false;
    }
    dnt_pushed = true
    dislike(item, donotlikebtn)
    setTimeout(function(){
      dnt_pushed = false
    }, 800)
  });
  let lk_pushed = false
  const likebtn = document.getElementById("likebtn")
  likebtn.addEventListener("click", (item) => {
    if(lk_pushed == true){
      return false
    }
    lk_pushed = true
    like(item, likebtn)
    setTimeout(function(){
      lk_pushed = false
    }, 800)

  } );

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

  let switching = false
  const img2 = document.getElementById('redo_info')
  if(img2 != null){
    img2.addEventListener('click', () => {
      if(document.getElementsByClassName('card__wrappers')[0] != undefined ){
        document.getElementsByClassName('card__wrappers')[0].className = 'card__wrapper'
      }
      if (switching) {
        return false
      }
      console.log('hey');
      switching = true
      flipCard()
      switching = false
    })
  }
  const img = document.getElementById('redo_img')
  if(img != null){
    img.addEventListener('click', () => {
      if(document.getElementsByClassName('card__wrappers')[0] != undefined ){
        document.getElementsByClassName('card__wrappers')[0].className = 'card__wrapper'
      }
      if (switching) {
        return false
      }
      console.log('hey');
      switching = true
      flipCard()
      switching = false
    })
  }

  document.addEventListener('keyup', function(event) {
    const code = event.keyCode;
      if (code == '40') {
          // down
        // const info_hidden = document.getElementsByClassName("info-section")[0];
        // info_hidden.classList.toggle("really_hidden");
        if(document.getElementsByClassName('card__wrappers')[0] != undefined ){
          document.getElementsByClassName('card__wrappers')[0].className = 'card__wrapper'
        }
        if (switching) {
          return false
        }
        switching = true
        flipCard()
        switching = false
      }
   })
});
