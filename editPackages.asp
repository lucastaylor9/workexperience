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
            DIM con, cmd, RS, destination, capacity, departuretime, returntime

            SET con = Server.CreateObject("ADODB.Connection")
            con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            con.open

            if request("Action") = "Create" then 

                SET cmd = Server.CreateObject("ADODB.Command") 
                SET cmd.ActiveConnection = con

                'Prepare the stored procedure
                cmd.CommandText = "[dbo].[changePackages]"
                cmd.CommandType = 4  'adCmdStoredProc 

                SET PackageID=cmd.CreateParameter ("@PackageID",3,1,,request("ID"))
                cmd.Parameters.Append PackageID

                SET destination=cmd.CreateParameter ("@destination",200,1,20,request("destination"))
                cmd.Parameters.Append destination

                SET capacity=cmd.CreateParameter ("@capacity",3,1,,request("capacity"))
                cmd.Parameters.Append capacity

                SET departuretime=cmd.CreateParameter ("@departuretime",133,1,,request("departuretime"))
                cmd.Parameters.Append departuretime

                SET returntime=cmd.CreateParameter ("@returntime",133,1,,request("returntime"))
                cmd.Parameters.Append returntime

                'Set the record set
                SET RS = Server.CreateObject("ADODB.recordset")

                'Execute the stored procedure
                cmd.Execute
                SET cmd = Nothing
            end if
            
            SET cmd = Server.CreateObject("ADODB.Command")
            SET cmd.ActiveConnection = con

            'Prepare the stored procedure
            cmd.CommandText = "[dbo].[gatherPackage]"
            cmd.CommandType = 4  'adCmdStoredProc

            SET PackageID=cmd.CreateParameter ("@PackageID",3,1,,request("ID"))
            cmd.Parameters.Append PackageID

            'Set the record set
            SET RS = Server.CreateObject("ADODB.recordset")

            'Execute the stored procedure
            SET RS = cmd.Execute
            SET cmd = Nothing
            SET con = Nothing
            %>
        </head>
        <body>
            <h1>Welcome to our Edit Packages page</h1>
            <form id = "form" action="/editPackages.asp">
                    Destination: <input type="text" name = "destination" id = "destination" value="<%response.write RS(1)%>">
                    Capacity: <input type="text" name = "capacity" id = "capacity" value="<%response.write RS(2)%>">
                    Departure Time: <input type="text" name = "departuretime" id = "departuretime" value="<%response.write RS(3)%>">
                    Return Time: <input type="text" name = "returntime" id = "returntime" value="<%response.write RS(4)%>">
                    <input type="hidden" name = "Action" value = "Create">
                    <input type="hidden" name = "ID" value = "<%=request("ID")%>">
            </form>
            <button onclick="submit();">Submit</button>

            <p>Click to return to the Packages page.</p>
            <button id = "Packages">Packages</button>
        </body>
</html>
