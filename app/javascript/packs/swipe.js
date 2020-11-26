let cardTransitionTime = 500;

export function flipCard () {  
  document.getElementsByClassName('js-card')[0].classList.toggle('is-switched')
  window.setTimeout(function () {
      document.getElementsByClassName('card__side')[0].classList.toggle("is-active")
      document.getElementsByClassName('card__side--back')[0].classList.toggle("is-active")
  }, cardTransitionTime / 2)
}

export function movie(user_id, event_id){
  // fetch(`https://mooovienight.herokuapp.com/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {

    if(json['closed'] == 1) {
      // window.location.replace(`https://mooovienight.herokuapp.com/event/result/${event_id}`);
      window.location.replace(`http://localhost:3000/event/result/${event_id}`);
    }

    let c_arr = json['count']
    c_arr.forEach((item) => {
      let id = item[0]
      let count = item[1]
      document.getElementById(`c_${id}`).innerHTML = count
    });
    if(document.getElementById('likebtn')){
      document.getElementById('likebtn').style.opacity = 0.3;
    } else {
      document.getElementById('deactivatel').style.opacity = 0.3;
    }
    if (document.getElementById('donotlikebtn')){
      document.getElementById('donotlikebtn').style.opacity = 0.3;
    } else {
      document.getElementById('deactivaten').style.opacity = 0.3;
    }  
    document.getElementById('matches').innerHTML = `${json['matches']}<i class="fas fa-star">`
    document.getElementById("movie_name").innerHTML = `${json['title']}`
    document.getElementById("movie_title_small").innerHTML = `${json['title']}`
    document.getElementById('event_movie_id').innerHTML = json['id']
    let src = json['poster']
    document.getElementsByClassName('bg-image')[0].style.backgroundImage =`url('${src}')`;
    smooth(document.getElementsByClassName('bg-image')[0], 0.75, 400)

    document.getElementById("move").style.top ="0px"; 
    document.getElementById("move").style.left ="-150px";
    document.getElementById("move").style.color = "white";
    document.getElementById("move").style.height = "454px"; 
    document.getElementById("move").style.width = "280px"; 
    document.getElementById("img").style.padding = "10px";
    document.getElementById("move").style.fontSize = "15px";
    smooth(document.getElementById("move"), 1)

    // document.getElementsByClassName('bg-image')[0].style.opacity = 0

    document.getElementsByClassName('image')[0].src = src
  
    document.getElementById("movie_director").innerHTML = `Director: ${json['director']}`
    document.getElementById("movie_synopsys").innerHTML = json['synopsis'] 
    document.getElementById("movie_actors").innerHTML =  `Actors: ${json['actors']}`
    document.getElementById("small_img").innerHTML = json['cover']
  })
}

export function smooth_list(elem1, elem2, max1, max2, time = 200.0) {
  var id = setInterval(frame, 5);
  function frame() {
      let opacity1 = parseFloat(elem1.style.opacity)
      let opacity2 = parseFloat(elem2.style.opacity)
      if(opacity1 == ""){
        opacity1 = 0.0
      }
      if(opacity2 == ""){
        opacity2 = 0.0
      }
      if (opacity1 >= max1) {
        clearInterval(id);
      } else {
        let n_o1 = opacity1+(max1/time)
        let n_o2 = opacity2+(max2/time)
        elem1.style.opacity = `${n_o1}`
        elem2.style.opacity = `${n_o2}`
      }
    }
}

export function dislike(item, donotlikebtn){
  donotlikebtn.id = "deactivaten"
  item.preventDefault();
  if(document.getElementsByClassName('js-card')[0].classList.contains("is-switched")){
    flipCard()
    setTimeout(function(){
      dislike_fn(item, donotlikebtn)
    }, 350)
  } else {
    dislike_fn(item, donotlikebtn)
  }
}

function dislike_fn(item, donotlikebtn){
  const like_event = document.getElementById("move");
  // like_event.classList.add("slide-in-left");
  myMoveLike(0)
  const user_id = document.getElementById('user_id').innerHTML
  const event_id = document.getElementById('event_id').innerHTML
  const event_movie_id = document.getElementById('event_movie_id').innerHTML
  const liked = 0
  // fetch(`https://mooovienight.herokuapp.com/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
    setTimeout(function(){
      // like_event.classList.remove("slide-in-left");
      donotlikebtn.id = "donotlikebtn"
      }, 600);
  })
}

export function like(item, likebtn){
  likebtn.id = "deactivatel"
  item.preventDefault();
  if(document.getElementsByClassName('js-card')[0].classList.contains("is-switched")){
    flipCard()
    setTimeout(function(){
      like_fn(item, likebtn)
    }, 350)
  } else {
    like_fn(item, likebtn)
  }
}

function like_fn(item, likebtn){
  document.getElementsByClassName('swipes-history')[0].insertAdjacentHTML("afterbegin",`<li class="list-inline-item"> <img src="${document.getElementById("small_img").innerHTML}"/> </li>`)
  const like_event2 = document.getElementById("move");
  // like_event2.classList.add("slide-in-right");
  myMoveLike(1)
  const user_id = document.getElementById('user_id').innerHTML
  const event_id = document.getElementById('event_id').innerHTML
  const event_movie_id = document.getElementById('event_movie_id').innerHTML
  const liked = 1
  // fetch(`https://mooovienight.herokuapp.com/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
    setTimeout(function(){
      // like_event2.classList.remove("slide-in-right");
      likebtn.id = "likebtn"
      }, 600);
  })
}

export function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  const init_x = elmnt.offsetTop
  const init_y = elmnt.offsetLeft
  elmnt.onmousedown = dragMouseDown;
  

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    let x = elmnt.style.left
    if(parseInt(x.substring(0, x.length - 2)) > 200){
      document.getElementById('likebtn').style.opacity = 1
    } else if (parseInt(x.substring(0, x.length - 2)) < -500) {
      document.getElementById('donotlikebtn').style.opacity = 1
    } else {
      document.getElementById('likebtn').style.opacity = 0.3
      document.getElementById('donotlikebtn').style.opacity = 0.3
      elmnt.style.color = 'white';
    }
  }

  function closeDragElement(e) {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;

    myMove(-150, 0)
  }

  function myMove(final_x, final_y) {
    var elem = document.getElementById("move");   
    var id = setInterval(frame, 5);
    let x = elem.style.left;
    x = parseInt(x.substring(0, x.length - 2));
    let y = elem.style.top;
    y = parseInt(y.substring(0, y.length - 2));
    function frame() {
      if(x > 200){
        clearInterval(id);
        document.getElementById("likebtn").click();
      } else if (x < -500) {
        clearInterval(id);
        document.getElementById("donotlikebtn").click();
        
      } else {
        elmnt.style.color = 'white';
        if (x == final_x && y == final_y) {
          clearInterval(id);
        } else {
          let dist_y = Math.abs(y-final_y)
          let dist_x = Math.abs(x-final_x)
          let move_x = Math.ceil((dist_x/20))
          let move_y = Math.ceil((dist_y/20))
          if(final_x > x){
            x += move_x
          } else if(final_x < x) {
            x -= move_x
          }
          if(final_y> y){
            y += move_y
          } else if(final_y < y) {
            y -= move_y
          }
          elem.style.top = y + "px"; 
          elem.style.left = x + "px"; 
        }
      }
    }
  }
}

export function smooth(elem, max, time = 200.0) {
  var id = setInterval(frame, 5);
  function frame() {
      let opacity = parseFloat(elem.style.opacity)
      if(opacity == ""){
        opacity = 0.0
      }
      if (opacity >= max) {
        clearInterval(id);
      } else {
        let n_o = opacity+(max/time)
        elem.style.opacity = `${n_o}`
      }
    }
}

export function myMoveLike(val) {
  let final_x = 0
  let final_y = 0
  if(val == 1){
    final_x = 600
    final_y = 200
  } else {
    final_x = -600
    final_y = 200
  }
  var elem = document.getElementById("move");   
  var id = setInterval(frame, 5);
  let x = elem.style.left;
  x = parseInt(x.substring(0, x.length - 2));
  let y = elem.style.top;
  y = parseInt(y.substring(0, y.length - 2));
  function frame() {
    if (elem.style.opacity <= 0 && document.getElementsByClassName('bg-image')[0].style.opacity < 0) {
      document.getElementsByClassName('bg-image')[0].style.opacity = 0
      elem.style.opacity = 0
      clearInterval(id);
      const user_id = document.getElementById('user_id').innerHTML
      const event_id = document.getElementById('event_id').innerHTML
      movie(user_id, event_id)
    } else {
      let dist_y = Math.abs(y-final_y)
      let dist_x = Math.abs(x-final_x)

      let move_x = Math.ceil((dist_x/20))
      let move_y = Math.ceil((dist_y/20))

      let size_x = elem.style.width
      let size_y = elem.style.height

      let opacity = elem.style.opacity
      if(opacity == ""){
        opacity = 1
      }
      let opacity_b = document.getElementsByClassName('bg-image')[0].style.opacity
      if(opacity_b == ""){
        opacity_b = 0.75
      }
      console.log(opacity_b);

      let padding = document.getElementById("img").style.padding
      if(padding == ""){
        padding = 10
      } else {
        padding = parseInt(padding.substring(0, padding.length -2))
      }
      

      let t_size = elem.style.fontSize
      if(t_size == ""){
        t_size = 15
      } else {
        t_size = parseInt(t_size.substring(0, t_size.length -2))
      }
      if(size_x == ""){
        size_x = 280
        size_y = 454
      } else {
        size_x = parseInt(size_x.substring(0, size_x.length - 2));
        size_y = parseInt(size_y.substring(0, size_y.length - 2));
      }
      let small_x = Math.ceil((size_x/20))
      let small_y = Math.ceil((size_y/20))
      
      if(final_x > x){
        x += move_x
      } else if(final_x < x) {
        x -= move_x
      }
      if(final_y> y){
        y += move_y
      } else if(final_y < y) {
        y -= move_y
      }
      let s_x = size_x - small_x
      let s_y = size_y - small_y
      t_size = t_size - 1
      padding = padding - 1

      elem.style.top = y + "px"; 
      elem.style.left = x + "px";
      elem.style.height = s_y + "px"; 
      elem.style.width = s_x + "px"; 
      document.getElementById('img').style.padding = padding + "px"
      elem.style.fontSize = t_size + "px"
      elem.style.opacity = opacity - 0.02
      
      if(opacity_b-0.015 >= 0){
        document.getElementsByClassName('bg-image')[0].style.opacity = opacity_b-0.015
      }
    }
    
  }
}