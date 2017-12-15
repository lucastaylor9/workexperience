<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
        </style>
        <script type="text/javascript">
            window.onload = function(){
                document.getElementById("Client").onclick = function () {
                    location.href = "./client.asp"
                };
                document.getElementById("Booking").onclick = function () {
                    location.href = "./booking.asp"
                };
                document.getElementById("Packages").onclick = function () {
                    location.href = "./packages.asp"
                };
            };
        </script>
        
    </head>
    <body>
        <h1>Welcome to our travel website</h1>
        <p>Choose Clients, Bookings or Packages.</p>
        <button id = "Client">Client</button>
        <button id = "Booking">Bookings</button>
        <button id = "Packages">Packages</button>
    </body>
</html>