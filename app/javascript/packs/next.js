import { smooth } from './swipe'

export function show(){
  const winner = document.getElementById('winner')
  const winner_s = document.getElementById('winner_s')
  winner.style.position = "absolute"
  winner.style.left = "-70px"
  winner.style.zIndex = 100
  winner.classList.remove('really_hidden')
  winner.style.left = (winner_s.offsetLeft) +"px" // postion start
  winner.style.top = (winner_s.offsetTop)+"px"  // postion start

  let x= winner.style.top;
  let y = winner.style.left;
  x = parseInt(x.substring(0, x.length - 2));
  y = parseInt(y.substring(0, y.length - 2));
  const end_left = Math.ceil(((window.innerHeight/2)-30)) // postion end
  const end_top = Math.ceil((window.innerHeight/5)) // postion end
  winner.style.opacity = 0;
  winner.style.height = "100px"
  winner.style.width = "70px"
  move(end_top, end_left, winner, Math.abs(x-end_top), Math.abs(y-end_left), 390, 260) 
}

let i_h = 0.5
function move(final_x, final_y, elem, tot_x, tot_y, final_h, final_w, tot_h = 290, tot_w = 190) { 
  var id = setInterval(frame, 10);
  let x= elem.style.top;
  let y = elem.style.left;
  let h = elem.style.height;
  let w = elem.style.width

  h = parseInt(h.substring(0, h.length - 2));
  w = parseInt(w.substring(0, w.length - 2));
  x = parseInt(x.substring(0, x.length - 2));
  y = parseInt(y.substring(0, y.length - 2));

  function frame() {
    if (x == final_x && y == final_y) {
      i_h = 0.5
      clearInterval(id);
    } else {
      let dist_y = Math.abs(y-final_y)
      let dist_x = Math.abs(x-final_x)

      let dist_h = Math.abs(h-final_h)
      let dist_w = Math.abs(w-final_w)

      i_h = i_h*1.025
      let move_x = i_h*(dist_x/tot_x)
      let move_y = i_h*(dist_y/tot_y)
      let move_h = i_h*(dist_h/tot_h)
      let move_w = i_h*(dist_w/tot_w)
      if(final_x > x){
        x += move_x
        if(x > final_x){
          x = final_x
        }
      } else if(final_x < x) {
        x -= move_x
        if(x < final_x){
          x = final_x
        }
      }
      if(final_y > y){
        y += move_y
        if(y > final_y){
          y = final_y
        }
      } else if(final_y < y) {
        y -= move_y
        if(y < final_y){
          y = final_y
        }
      }
      if(h + move_h > final_h){
        h = final_h
      } else {
        h += move_h
      }
      if(w + move_w > final_w){
        w = final_w
      } else {
        w += move_w
      }
      elem.style.top = x + "px"; 
      elem.style.left = y + "px";
      elem.style.width = w + "px";
      elem.style.height = h + "px";
      elem.style.opacity = parseFloat(elem.style.opacity) + 0.01
      document.getElementsByClassName('bg-image')[0].style.opacity = parseFloat(document.getElementsByClassName('bg-image')[0].style.opacity) + 0.0075
      const arrays = document.getElementsByClassName('res_card')
      for (let i = 0; i < arrays.length; i++) {
        const elems = arrays[i];
        let opa = elems.style.opacity
        if(opa == ""){
          opa = 1
        } else {
          opa = parseFloat(opa)
        }
        elems.style.opacity = opa - 0.01
      }
    }
  }
}