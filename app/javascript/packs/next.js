import { smooth } from './swipe'
export function nextMovie(){
  let array = [...document.getElementsByClassName("movie")]
  console.log(array);
  for (let i = 0; i < array.length; i++) {
    const element = array[i];
    if(!element.classList.contains('really_hidden')){
      if(i == array.length - 1){
        element.classList.add('really_hidden')
        array[0].classList.remove('really_hidden')
        let item = array[0].children[1]
        item.style.opacity = 0
        smooth(item, 1, 800)
        updatebg(array[0].children[1].children[0].children[0].children[1].src, item)
        break
      } else {
        let item = array[i+1].children[1]
        item.style.opacity = 0
        smooth(item, 1, 800)
        element.classList.add('really_hidden')
        array[i+1].classList.remove('really_hidden')
        updatebg(array[i+1].children[1].children[0].children[0].children[1].src, item)
        break
      }
    }
  }
}


function updatebg(src){
  document.getElementsByClassName('bg-image')[0].style.opacity = 0
  document.getElementsByClassName('bg-image')[0].style.backgroundImage =`url('${src}')`;
  document.getElementsByClassName('bg-image')[0].style.backgroundSize = "cover";
  document.getElementsByClassName('bg-image')[0].style.backgroundPosition = "0% 50%";
  smooth(document.getElementsByClassName('bg-image')[0], 0.75, 800)
}