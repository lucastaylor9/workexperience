<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
            <style>
            </style>

            <script type="text/javascript">
                window.onload = function() {
                    document.getElementById("Main").onclick = function () {
                        location.href = "./main.asp"
                    }
                };
                window.onload = function() {
                    document.getElementById("addBooking").onclick = function () {
                        location.href = "./newBooking.asp"
                    }
                };
                window.onload = function() {
                    document.getElementById("ClientID").onchange = function () {
                        var ClientID = document.getElementById("ClientID").value
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                var str = this.responseText;
                                str = str.slice(0, -1);
                                var arr = str.split(",");
                                var x;
                                for (x in document.getElementById("PackageID").options) {
                                    if (!(arr.includes(document.getElementById("PackageID").options[x].value))) {
                                        document.getElementById("PackageID").options[x].disabled = true;
                                    }
                                }
                            }
                        };
                        xhttp.open("GET", "AJAXPackages.asp?ID=" + ClientID, true);
                        xhttp.send();
                    }
                };
                function redirect (ID) {
                    location.href = "./editBooking.asp?ID=" + ID
                };
        </script>

            <%
            DIM con
        SET con = Server.CreateObject("ADODB.Connection")
        con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"
        con.open

        DIM cmd
        SET cmd = Server.CreateObject("ADODB.Command") 
        SET cmd.ActiveConnection = con
        
        'Set the record set
        DIM RS
        SET RS = Server.CreateObject("ADODB.recordset")
        
        'Prepare the stored procedure
        cmd.CommandText = "[dbo].[spgatherClientPackage]"
        cmd.CommandType = 4  'adCmdStoredProc
        
        'Execute the stored procedure
        SET RS = cmd.Execute
        SET cmd = Nothing
        %>
    </head>
        <body>
            <h1>Welcome to our Bookings page</h1>

            <form action="/booking.asp">

                <select id="ClientID" name="ClientID">
                    <option value="0">Client Name</option>
                    <%
                    'You can now access the record set
                WHILE NOT RS.EOF
                    response.write "<option value="""
                    response.write RS(0)
                    response.write """>"
                    response.write RS(1)
                    response.write "</option>"
                    RS.Movenext
                WEND
                SET RS=RS.nextrecordset()
                %>
            </select>

            <select id="PackageID" name="PackageID">
                <option value="0">Package Name</option>
                <%
                'You can now access the record set
                WHILE NOT RS.EOF
                    response.write "<option value="""
                response.write RS(0)
                    response.write """>"
                    response.write RS(1)
                    response.write "</option>"
                    RS.Movenext
                WEND
                %>
            </select>
        </form>

    <table>
        <tr id="headers">
            <th>ClientId</th>
            <th>Booking Date</th>
            <th>PackageID</th>
            <th>Edit</th>
        </tr>
        <%
        'You can now access the record set
            WHILE NOT RS.EOF
                response.write "<tr class='data'>"
                response.write "<td>"&RS(1)&"</td>"
                response.write "<td>"+RS(2)+"</td>"
                response.write "<td>"&RS(3)&"</td>"
                response.write "<td><button onclick="" redirect("&RS(0)&")"">Edit</button></td></tr>"
                RS.Movenext
            WEND
            %>
            </table>
    <p>Click to return to the Main page.</p>
    <button id="Main">Main</button>
    <p>Add a new Booking Date.</p>
    <button id="addBooking">Add Booking</button>
    </body >
</html >