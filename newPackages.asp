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
                    document.getElementById("Packages").onclick = function () {
                        location.href = "./packages.asp"
                    };
                };
                function submit() {
                    var destination, capacity, departuretime, returntime;
                    destination = document.getElementById("destination").value;
                    capacity = document.getElementById("capacity").value;
                    departuretime = document.getElementById("departuretime").value;
                    returntime = document.getElementById("returntime").value;
                    try { 
                        if(destination == "")  throw "Empty Destination Field";
                        if(capacity == "")  throw "Empty Capacity Field";
                        if(departuretime == "")  throw "Empty Departure Time Field";
                        if(returntime == "")  throw "Empty Return Time Field";
                        document.getElementById("form").submit();
                    }
                    catch(err) {
                        alert(err);
                    }
                }
            </script>
            <%
            if request("Action") = "Create" then 
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
                cmd.CommandText = "[dbo].[spnewPackages]"
                cmd.CommandType = 4  'adCmdStoredProc 


                DIM destination
                SET destination=cmd.CreateParameter ("@destination",200,1,20,request("destination"))
                cmd.Parameters.Append destination

                DIM capacity
                SET capacity=cmd.CreateParameter ("@capacity",3,1,,request("capacity"))
                cmd.Parameters.Append capacity

                DIM departuretime
                SET departuretime=cmd.CreateParameter ("@departuretime",133,1,,request("departuretime"))
                cmd.Parameters.Append departuretime

                DIM returntime
                SET returntime=cmd.CreateParameter ("@returntime",133,1,,request("returntime"))
                cmd.Parameters.Append returntime

                'Execute the stored procedure
                SET RS = cmd.Execute
                SET cmd = Nothing
            end if
            %>
        </head>
        <body>
            <h1>Welcome to our Add Packages page</h1>
            <form id = "form" action="/newPackages.asp">
                    Destination: <input type="text" name = "destination" id = "destination">
                    Capacity: <input type="text" name = "capacity" id = "capacity">
                    Departure Time: <input type="text" name = "departuretime" id = "departuretime">
                    Return Time: <input type="text" name = "returntime" id = "returntime">
                    <input type="hidden" name = "Action" value = "Create">
            </form>
            <button onclick="submit();">Submit</button>

            <p>Click to return to the Packages page.</p>
            <button id = "Packages">Packages</button>
        </body>
</html>