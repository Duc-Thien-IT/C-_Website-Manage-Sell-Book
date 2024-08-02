function ShowAllNew(className) {
    var cardItems = document.getElementsByClassName(className);
    for (var i = 0; i < cardItems.length; i++) {
        cardItems[i].style.display = "flex";
    }
    var button = document.getElementById("button-new");
    button.style.display = "none";
}

var button = document.getElementById("button-new");
button.onclick = function() {
    ShowAllNew("active-new");
};
