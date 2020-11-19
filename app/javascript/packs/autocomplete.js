function genre(string, ul){
  fetch(`http://localhost:3000/api/genre/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul)})
}

function actor(string, ul){
  fetch(`http://localhost:3000/api/actor/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul)})
}

function director(string, ul){
  fetch(`http://localhost:3000/api/director/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul)})
}

function create(array, ul) {
  for (let index = 0; index < array.length; index += 1) {
    array.forEach((item) => {
      ul.insertAdjacentHTML("beforeend", `<li>${item}</li>`);
    });
  }
}

function predict(val, e) {
  const text = e.value;
  if(text.length > 3){
    const ul = document.getElementById(`results_${val}`);
    ul.innerHTML = "";
    if(val === 0){
      genre(text, ul)
    } else if (val === 1){
      actor(text, ul)
    } else {
      director(text, ul)
    }
  }
}

// genre = document.getElementById("genre_pref")
// if(genre != null){
//   genre.addEventListener('keyup', (e) => { predict('genre',e) }, false);
// }

// actor = document.getElementById("actor_pref")
// if(actor != null){
//   actor.addEventListener('keyup', (e) => { predict('actor', e) }, false);
// }

// director = document.getElementById("director_pref")
// if(director != null){
//   director.addEventListener('keyup', (e) => { predict('director', e) }, false);
// }