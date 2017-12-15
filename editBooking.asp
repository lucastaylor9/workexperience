<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            form {
                padding: 10px;
                width: 4cm;
                font-size: 20px;
                border-style: solid;
                border-width: 5px;
                border-color:cyan;
                text-decoration: underline;
                border-radius: 1cm;;
                color: rgb(26, 26, 199);
            }
        </style>
        <%
        DIM con, cmd, RS1,RS2, ClientID, bookingDate, PackageID, BookingID

            SET con = Server.CreateObject("ADODB.Connection")
            con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"
            con.open

        if request("Action") = "Create" then
            SET cmd = Server.CreateObject("ADODB.Command") 
            SET cmd.ActiveConnection = con

            'Prepare the stored procedure
            cmd.CommandText = "[dbo].[changeBooking]"
            cmd.CommandType = 4  'adCmdStoredProc 

            SET ClientID=cmd.CreateParameter ("@ClientID",3,1,,request("ClientID"))
            cmd.Parameters.Append ClientID

            SET bookingDate=cmd.CreateParameter ("@bookingDate",133,1,,request("bookingDate"))
            cmd.Parameters.Append bookingDate

            SET PackageID=cmd.CreateParameter ("@PackageID",3,1,,request("PackageID"))
            cmd.Parameters.Append PackageID

            SET ID=cmd.CreateParameter ("@ID",3,1,,request("ID"))
            cmd.Parameters.Append ID

            'Execute the stored procedure
            cmd.Execute
            SET cmd = Nothing
        end if

            SET cmd = Server.CreateObject("ADODB.Command") 
            SET cmd.ActiveConnection = con

            'Prepare the stored procedure
            cmd.CommandText = "[dbo].[spgatherClientPackage]"
            cmd.CommandType = 4  'adCmdStoredProc 

            'Set the record set
            SET RS1 = Server.CreateObject("ADODB.recordset")

            'Execute the stored procedure
            SET RS1 = cmd.Execute
            SET cmd = Nothing

            SET cmd = Server.CreateObject("ADODB.Command") 
            SET cmd.ActiveConnection = con

            'Prepare the stored procedure
            cmd.CommandText = "[dbo].[gatherBookingInfo]"
            cmd.CommandType = 4  'adCmdStoredProc 

            SET BookingID=cmd.CreateParameter ("@BookingID",3,1,,request("ID"))
            cmd.Parameters.Append BookingID

            'Set the record set
            SET RS2 = Server.CreateObject("ADODB.recordset")

            'Execute the stored procedure
            SET RS2 = cmd.Execute
            SET cmd = Nothing

            SET con = Nothing
        %>
        <script type="text/javascript">
            window.onload = function(){
                document.getElementById("Booking").onclick = function () {
                    location.href = "./Booking.asp"
                };
                document.getElementById("ClientID").value = "<%response.write RS2(1)%>"
                document.getElementById("PackageID").value = "<%response.write RS2(3)%>"
            };
            function submit() {
                var ClientID, bookingdate;
                bookingdate = document.getElementById("bookingdate").value;
                ClientID = document.getElementById("ClientID").value;
                PackageID = document.getElementById("PackageID").value;
                try { 
                    if(bookingdate == "")  throw "Empty Booking Date";
                    if(ClientID == "0")  throw "Empty ClientID";
                    if(PackageID == "0")  throw "Empty PackageID";
                    document.getElementById("form").submit();
                }
                catch(err) {
                    alert(err);
                }
            }
        </script>

    </head>
    <body>
        <h1>Welcome to our Edit Booking page</h1>
        <form id = "form" action="/editBooking.asp">
            Booking Date: <input type="text" id = "bookingdate" name = "bookingdate" value="<%response.write RS2(2)%>">
            <input type="hidden" name = "Action" value = "Create">
            <input type="hidden" name = "ID" value = "<%=request("ID")%>">

            <select id = "ClientID" name = "ClientID">
                <option value="0">Client Name</option>
                <%
                    'You can now access the record set
                WHILE NOT RS1.EOF
                    response.write "<option value= """
                    response.write RS1(0)
                    response.write """>"
                    response.write RS1(1)
                    response.write "</option>"
                    RS1.Movenext
                WEND
                SET RS1=RS1.nextrecordset()
                %>
            </select>

            <select id ="PackageID" name ="PackageID">
                <option value="0">Package Name</option>
                <%
                    'You can now access the record set
                WHILE NOT RS1.EOF
                    response.write "<option value= """
                    response.write RS1(0)
                    response.write """>"
                    response.write RS1(1)
                    response.write "</option>"
                    RS1.Movenext
                WEND
                %>
            </select>
        </form>
        <button onclick="submit();">Submit</button>

        <p>Click to return to the Booking page.</p>
        <button id = "Booking">Booking</button>
    </body>
</html>