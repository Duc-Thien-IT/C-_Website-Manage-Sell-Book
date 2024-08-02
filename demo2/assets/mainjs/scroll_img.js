const bigImg = document.querySelector(".container_bottom_left_big-img img")
const smallImg = document.querySelectorAll(".container_bottom_left_small-img img")
    smallImg.forEach(function(ImgItem, x){
    ImgItem.addEventListener("click", function(){ 
        bigImg.src = ImgItem.src
    })
})