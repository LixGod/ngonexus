let currentIndex = 0;

function moveSlide(n) {
    let items = document.getElementsByClassName('slide');
    currentIndex += n;

    if (currentIndex >= items.length) {
        currentIndex = 0;
    } else if (currentIndex < 0) {
        currentIndex = items.length - 1;
    }

    for (let i = 0; i < items.length; i++) {
        items[i].style.transform = `translateX(-${currentIndex * 100}%)`;
    }
}