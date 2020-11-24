export function movie(user_id, event_id){
  // fetch(`https://mooovienight.herokuapp.com/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {
    console.log('hello');
    console.log(json);
    document.getElementById("movie_name").innerHTML = `Title: ${json['title']}`
    document.getElementById('event_movie_id').innerHTML = json['id']
    fetch(`https://api.themoviedb.org/3/search/movie?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&query=${json['title']}`)
    .then(response => response.json())
    .then((json) => {
      let src = `http://image.tmdb.org/t/p/w500/${json["results"][0]['poster_path']}`
      console.log(src);
      document.getElementsByClassName('image')[0].src = src
    })
    
    document.getElementById("movie_director").innerHTML = `Director: ${json['director']}`
    document.getElementById("movie_synopsys").innerHTML = json['synopsis'] 
    document.getElementById("movie_actors").innerHTML =  `Actors: ${json['actors']}`
  })
}

export function review(user_id, event_movie_id, liked){
  fetch(`https://mooovienight.herokuapp.com/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
  // fetch(`http://localhost:3000/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
    console.log(json);
  })
}

export function dislike(item, donotlikebtn){
  donotlikebtn.id = "deactivate"
  item.preventDefault();
  const like_event = document.getElementById("movie_name");
  const like_event1= document.getElementById("img_swipe");
  like_event.classList.add("slide-in-left");
  like_event1.classList.add("slide-in-left");

  const user_id = document.getElementById('user_id').innerHTML
  const event_id = document.getElementById('event_id').innerHTML
  const event_movie_id = document.getElementById('event_movie_id').innerHTML
  const liked = 0
  // fetch(`https://mooovienight.herokuapp.com/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
    setTimeout(function(){
      like_event.classList.remove("slide-in-left");
      like_event1.classList.remove("slide-in-left");
      donotlikebtn.id = "donotlikebtn"
      }, 600);
    
    setTimeout(function(){
      movie(user_id, event_id)
    }, 350)
  })
}

export function like(item, likebtn){
  likebtn.id = "deactivate"
  item.preventDefault();
  const like_event2 = document.getElementById("movie_name");
  const like_event3 = document.getElementById("img_swipe");
  like_event2.classList.add("slide-in-right");
  like_event3.classList.add("slide-in-right");

  const user_id = document.getElementById('user_id').innerHTML
  const event_id = document.getElementById('event_id').innerHTML
  const event_movie_id = document.getElementById('event_movie_id').innerHTML
  const liked = 0
  // fetch(`https://mooovienight.herokuapp.com/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/review/${user_id},${event_movie_id},${liked}`).then(response => response.json()).then((json) => {
    setTimeout(function(){
      like_event2.classList.remove("slide-in-right");
      like_event3.classList.remove("slide-in-right");
      likebtn.id = "likebtn"
      }, 600);
    
    console.log(user_id);
    setTimeout(function(){
      movie(user_id, event_id)
    }, 350)
  })
}

export function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

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
  }

  function closeDragElement(e) {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;

    myMove(Math.ceil(window.screen.width/5), Math.ceil(window.screen.height/7))
  }

  function myMove(final_x, final_y) {
    var elem = document.getElementById("move");   
    var id = setInterval(frame, 5);
    let x = elem.style.left;
    x = parseInt(x.substring(0, x.length - 2));
    let y = elem.style.top;
    y = parseInt(y.substring(0, y.length - 2));
    function frame() {
      if (x == final_x && y == final_y) {
        clearInterval(id);
      } else {
        let dist_y = Math.abs(y-final_y)
        let dist_x = Math.abs(x-final_x)
        let move_x = Math.ceil((dist_x/20))
        let move_y = Math.ceil((dist_y/20))
        console.log(move_x);
        console.log(move_y);
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