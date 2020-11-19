let selection = {
  'actor': [],
  'genre': [],
  'director': []
}

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
  array.forEach((item) => {
    ul.insertAdjacentHTML("beforeend", `<option value="${item}">`);
  });
}

export function predict(val, e) {
  const text = e.value;
  if(text.length >= 3){
    const ul = document.getElementById(`${val}s`);
    ul.innerHTML = "";
    if(val === 'genre'){
      genre(text, ul)
    } else if (val === 'actor'){
      actor(text, ul)
    } else {
      director(text, ul)
    }
  }
}