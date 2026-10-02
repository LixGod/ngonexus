<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Events</title>
    <link rel="stylesheet" href="css/eventstyle.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="proindex.jsp">Home</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <div class="carousel">
            <button class="prev" onclick="moveSlide(-1)">&#10094;</button>
            <div class="carousel-text">
                <div class="slide-container">
                    <div class="slide">
                    <img src="demoevent.png" alt="Error">
                </div>
                    <div class="slide">
                    <img src="demoevent.png" alt="Error">
                </div>
                    <div class="slide">
                    <img src="demoevent.png" alt="Error">
                </div>
                </div>
                <a href="bookevent.jsp" class="button">Book Your Spot</a>
            </div>
            <button class="next" onclick="moveSlide(1)">&#10095;</button>
        </div>
    </main>
    <script src="slider.js">
</script>
</body>
</html>