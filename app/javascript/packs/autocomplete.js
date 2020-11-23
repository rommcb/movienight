function genre(string, ul, val, value){
  // fetch(`https://mooovienight.herokuapp.com/api/genre/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})
  fetch(`http://localhost:3000/api/genre/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})

}

function actor(string, ul, val, value){
  // fetch(`https://mooovienight.herokuapp.com/api/actor/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})
  fetch(`http://localhost:3000/api/actor/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})

}

function director(string, ul, val, value){
  // fetch(`https://mooovienight.herokuapp.com/api/director/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})
  fetch(`http://localhost:3000/api/director/${string}`).then(response => response.json()).then((json) => {create(Object.values(json), ul, val, value)})

}

function edit_values_divs(val,values){
  let arr = values.split(",")
  arr.shift()
  let lock = document.getElementById(`locked_${val}`) 
  lock.innerHTML = ""
  arr.forEach((item) => {
    lock.insertAdjacentHTML("beforeend",`<div class='item_card'> <div class='txt'>${item}</div><div class="x" id="x_${val}_${item}">X</div></div>`)
    document.getElementById(`x_${val}_${item}`).addEventListener('click', () => {
      edit_values(val, values, item ,null)
    }, false)
  });
}

function edit_values(val, current_value, sub, add){
  if(sub == null){
    let values = current_value.split(",")
    if(!values.includes(add)){
      document.getElementById(`${val}_list`).value = `${current_value},${add}` 
    }
    edit_values_divs(val,document.getElementById(`${val}_list`).value)
  } else {
    let values = current_value.split(",")
    let new_values_arr = []
    values.forEach((item) => {
      if(item != sub){
        new_values_arr.push(item)
      }
    });
    let new_values_str = new_values_arr.join(",")
    document.getElementById(`${val}_list`).value = new_values_str
    edit_values_divs(val, new_values_str)
  }
  
}

function add_to_list(name, val, value){
  console.log(name)
  let current_value = document.getElementById(`${val}_list`).value
  edit_values(val, current_value, null, name)
  document.getElementById(`${val}_pref`).value = ""
  document.getElementById(`results_${val}`).innerHTML = "";
  document.getElementById(`results_${val}`).style.height = "0";
}

function create(array, ul, val, value) {
  if(array.length >= 8){
    ul.style.height = "190px"
  } else {
    ul.style.height = `${array.length*24}px`
  }
  ul.innerHTML="";
  array.forEach((item) => {
    ul.insertAdjacentHTML("beforeend", `<li id="${item}"} class="li_results">${item}</li>`);
    document.getElementById(item).addEventListener('click', () => {add_to_list(item, val, value)}, false)
  });
}

function predict(val, e) {
  const text = e.value;
  if(text.length == 0){
    document.getElementById(`results_${val}`).innerHTML = "";
    document.getElementById(`results_${val}`).style.height = "0";
  }
  let value = document.getElementById(`${val}_list`).value
  if(text.length >= 1){
    const ul = document.getElementById(`results_${val}`);
    if(val === 'genre'){
      genre(text, ul, val, value)
    } else if (val === 'actor'){
      actor(text, ul, val, value)
    } else {
      director(text, ul, val, value)
    }
  }
}

export function events(val, obj){
  edit_values_divs(val, document.getElementById(`${val}_list`).value)
  document.getElementById(`results_${val}`).onmouseover = function() {
    this.classList.add('active')
  };
  document.getElementById(`results_${val}`).onmouseout = function() {
    this.classList.remove('active')
  };


  obj.addEventListener('blur', () => {
      if(document.getElementById(`results_${val}`).classList.contains('active')){
        console.log('nope');
      } else {
        document.getElementById(`results_${val}`).style.display = 'none'; 
      }
  }, true);
  obj.addEventListener('focus', () => {
    document.getElementById(`results_${val}`).style.display = 'block';       
  }, true);
  obj.addEventListener('keyup', () => { predict(val, obj) }, false);
}