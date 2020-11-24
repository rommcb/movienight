export function movie(user_id, event_id){
  // fetch(`https://mooovienight.herokuapp.com/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {
  fetch(`http://localhost:3000/api/movie/${user_id},${event_id}`).then(response => response.json()).then((json) => {
    document.getElementById("movie_name").innerHTML = `${json['title']}`
    document.getElementById('event_movie_id').innerHTML = json['id']
    fetch(`https://api.themoviedb.org/3/search/movie?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&query=${json['title']}`)
    .then(response => response.json())
    .then((json) => {
      let src = `http://image.tmdb.org/t/p/w500/${json["results"][0]['poster_path']}`
      document.getElementById("move").style.top ="0px"; 
      document.getElementById("move").style.left ="-150px";
      document.getElementById("move").style.color = "white";
      document.getElementById("move").style.height = "454px"; 
      document.getElementById("move").style.width = "280px"; 
      document.getElementById("img").style.padding = "10px"
      document.getElementById("move").style.fontSize = "15px"

      document.getElementsByClassName('bg-image')[0].style.backgroundImage =`url('${src}')`;
      document.getElementsByClassName('bg-image')[0].style.backgroundSize = "cover";
      document.getElementsByClassName('bg-image')[0].style.backgroundPosition = "0% 50%";


      document.getElementsByClassName('image')[0].src = src
    })
    
    document.getElementById("movie_director").innerHTML = `Director: ${json['director']}`
    document.getElementById("movie_synopsys").innerHTML = json['synopsis'] 
    document.getElementById("movie_actors").innerHTML =  `Actors: ${json['actors']}`
  })
}

export function dislike(item, donotlikebtn){
  donotlikebtn.id = "deactivaten"
  item.preventDefault();
  const like_event = document.getElementById("move");
  // like_event.classList.add("slide-in-left");
  myMoveDisLike()
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
    
    setTimeout(function(){
      movie(user_id, event_id)
    }, 350)
  })
}

export function like(item, likebtn){
  likebtn.id = "deactivatel"
  item.preventDefault();
  const like_event2 = document.getElementById("move");
  // like_event2.classList.add("slide-in-right");
  myMoveLike()
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
    
    console.log(user_id);
    setTimeout(function(){
      movie(user_id, event_id)
    }, 350)
  })
}

export function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  const init_x = elmnt.offsetTop
  const init_y = elmnt.offsetLeft
  console.log(init_x);
  console.log(init_y);
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
      elmnt.style.color = 'green';
    } else if (parseInt(x.substring(0, x.length - 2)) < -500) {
      elmnt.style.color = 'red';
    } else {
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

export function myMoveLike() {
  let final_x = 600
  let final_y = 200
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

      let size_x = elem.style.width
      let size_y = elem.style.height

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
        console.log(size_x);
      } else {
        size_x = parseInt(size_x.substring(0, size_x.length - 2));
        size_y = parseInt(size_y.substring(0, size_y.length - 2));
      }
      let small_x = Math.ceil((size_x/10))
      let small_y = Math.ceil((size_y/10))
      
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
      padding = padding -1

      elem.style.top = y + "px"; 
      elem.style.left = x + "px";
      elem.style.height = s_x + "px"; 
      elem.style.width = s_y + "px"; 
      document.getElementById('img').style.padding = padding + "px"
      elem.style.fontSize = t_size + "px"
    }
    
  }
}
export function myMoveDisLike() {
  let final_x = -600
  let final_y = 200
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

      let size_x = elem.style.width
      let size_y = elem.style.height

      let padding = document.getElementById('img').style.padding
      if(padding == ""){
        padding = 10
      } else {
        padding = parseInt(padding.substring(0, padding.length -2))
      }
      console.log(padding);
      let t_size = elem.style.fontSize
      if(t_size == ""){
        t_size = 15
      } else {
        t_size = parseInt(t_size.substring(0, t_size.length -2))
      }

      if(size_x == ""){
        size_x = 280
        size_y = 454
        console.log(size_x);
      } else {
        size_x = parseInt(size_x.substring(0, size_x.length - 2));
        size_y = parseInt(size_y.substring(0, size_y.length - 2));
      }
      let small_x = Math.ceil((size_x/10))
      let small_y = Math.ceil((size_y/10))
      
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
      padding = padding -1

      elem.style.top = y + "px"; 
      elem.style.left = x + "px";
      elem.style.height = s_x + "px"; 
      elem.style.width = s_y + "px"; 
      document.getElementById('img').style.padding = padding + "px"
      elem.style.fontSize = t_size + "px"
    }
    
  }
}