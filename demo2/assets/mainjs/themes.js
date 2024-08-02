const toggleSwitch = document.querySelector('.theme-switch input[type="checkbox"]');
const currentTheme = localStorage.getItem('theme');
if (currentTheme) {
    document.documentElement.setAttribute('data-theme', currentTheme);
    if (currentTheme === 'dark') {
        toggleSwitch.checked = true;
        document.getElementById('img-themes').src = 'img/themes/sun-reading.svg';//thay đổi ảnh thành sun khi theme dark
        document.querySelector('.moon').classList.remove('note-moon');//ẩn chú thích của ảnh moon khi ảnh là sun
    }
    else{
        document.getElementById('img-themes').src = 'img/themes/moon-reading.svg';//ngược lại ở trên
        document.querySelector('.moon').classList.add('note-moon');//ngược lại ở trên
    }
}
function switchTheme(e) {
    if (e.target.checked) {
        document.documentElement.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
        document.getElementById('img-themes').src = 'img/themes/sun-reading.svg';
        document.querySelector('.moon').classList.remove('note-moon');
    } else {
        document.documentElement.setAttribute('data-theme', 'light');
        localStorage.setItem('theme', 'light');
        document.getElementById('img-themes').src = 'img/themes/moon-reading.svg';
        document.querySelector('.moon').classList.add('note-moon');
    }
}
toggleSwitch.addEventListener('change', switchTheme);


