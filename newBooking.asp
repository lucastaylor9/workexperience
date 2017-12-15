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
            <script type="text/javascript">
                window.onload = function(){
                    document.getElementById("Booking").onclick = function () {
                        location.href = "./Booking.asp"
                    };
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
            <%
                DIM con
                SET con = Server.CreateObject("ADODB.Connection")
                con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"
                con.open

                DIM cmd
                SET cmd = Server.CreateObject("ADODB.Command") 
                SET cmd.ActiveConnection = con

                'Prepare the stored procedure
                cmd.CommandText = "[dbo].[spgatherClientPackage]"
                cmd.CommandType = 4  'adCmdStoredProc 

                'Set the record set
                DIM RS
                SET RS = Server.CreateObject("ADODB.recordset")

                'Execute the stored procedure
                SET RS = cmd.Execute
                SET cmd = Nothing
                SET con = Nothing

            if request("Action") = "Create" then
                SET con = Server.CreateObject("ADODB.Connection")
                con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"  
                con.open

                SET cmd = Server.CreateObject("ADODB.Command") 
                SET cmd.ActiveConnection = con

                'Prepare the stored procedure
                cmd.CommandText = "[dbo].[spnewBooking]"
                cmd.CommandType = 4  'adCmdStoredProc 

                DIM ClientID
                SET ClientID=cmd.CreateParameter ("@ClientID",3,1,,request("ClientID"))
                cmd.Parameters.Append ClientID

                DIM bookingDate
                SET bookingDate=cmd.CreateParameter ("@bookingDate",133,1,,request("bookingDate"))
                cmd.Parameters.Append bookingDate

                DIM PackageID
                SET PackageID=cmd.CreateParameter ("@PackageID",3,1,,request("PackageID"))
                cmd.Parameters.Append PackageID

                'Execute the stored procedure
                cmd.Execute
                SET cmd = Nothing
            end if
            %>
        </head>
        <body>
            <h1>Welcome to our Add Booking page</h1>
            <form id = "form" action="/newBooking.asp">
                Booking Date: <input type="text" id = "bookingdate" name = "bookingdate">

                <select id = "ClientID" name = "ClientID">
                    <option value="0">Client Name</option>
                    <%
                        'You can now access the record set
                    WHILE NOT RS.EOF
                        response.write "<option value= """
                        response.write RS(0)
                        response.write """>"
                        response.write RS(1)
                        response.write "</option>"
                        RS.Movenext
                    WEND
                    SET RS=RS.nextrecordset()
                    %>
                </select>

                <select id ="PackageID" name ="PackageID">
                    <option value="0">Package Name</option>
                    <%
                        'You can now access the record set
                    WHILE NOT RS.EOF
                        response.write "<option value= """
                        response.write RS(0)
                        response.write """>"
                        response.write RS(1)
                        response.write "</option>"
                        RS.Movenext
                    WEND
                    %>
                </select>
                <input type="hidden" name = "Action" value = "Create">
            </form>
            <button onclick="submit();">Submit</button>

            <p>Click to return to the Booking page.</p>
            <button id = "Booking">Booking</button>
        </body>
</html>