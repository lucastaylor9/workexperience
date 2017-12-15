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
                    color: rgb(26, 28, 199);
                }
            </style>
            <script type="text/javascript">
                window.onload = function(){
                    document.getElementById("Client").onclick = function () {
                        location.href = "./Client.asp"
                    };
                };
                function submit() {
                    var name, DoB, phone;
                    name = document.getElementById("name").value;
                    DoB = document.getElementById("DoB").value;
                    phone = document.getElementById("phone").value;
                    try { 
                        if(name == "")  throw "Empty Name Field";
                        if(DoB == "")  throw "Empty Date Of Birth Field";
                        if(phone == "")  throw "Empty Phone Number Field";
                        document.getElementById("form").submit();
                    }
                    catch(err) {
                        alert(err);
                    }
                }
            </script>
            <%
            DIM con, cmd, RS, ClientID, name

            SET con = Server.CreateObject("ADODB.Connection")
            con.ConnectionString = "Provider=SQLOLEDB.1;Data Source=SPAREPC1\SQL2017;Initial Catalog=Work Experience;User ID=sa;Password=Password123;"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            con.open

            if request("Action") = "Create" then 
                SET cmd = Server.CreateObject("ADODB.Command") 
                SET cmd.ActiveConnection = con

                'Prepare the stored procedure
                cmd.CommandText = "[dbo].[changeClient]"
                cmd.CommandType = 4  'adCmdStoredProc 
                
                SET ClientID=cmd.CreateParameter ("@ClientID",3,1,,request("ID"))
                cmd.Parameters.Append ClientID

                SET name=cmd.CreateParameter ("@name",200,1,30,request("name"))
                cmd.Parameters.Append name
                
                SET DoB=cmd.CreateParameter ("@DoB",133,1,,request("DoB"))
                cmd.Parameters.Append DoB

                SET phone=cmd.CreateParameter ("@phone",129,1,11,request("phone"))
                cmd.Parameters.Append phone

                'Execute the stored procedure
                cmd.Execute
                SET cmd = Nothing
            end if

            SET cmd = Server.CreateObject("ADODB.Command")
            SET cmd.ActiveConnection = con

            'Prepare the stored procedure
            cmd.CommandText = "[dbo].[gatherClient]"
            cmd.CommandType = 4  'adCmdStoredProc 

            SET ClientID=cmd.CreateParameter ("@ClientID",3,1,,request("ID"))
            cmd.Parameters.Append ClientID

            'Set the record set
            SET RS = Server.CreateObject("ADODB.recordset")

            'Execute the stored procedure
            SET RS = cmd.Execute
            SET cmd = Nothing
            SET con = Nothing
            %>
        </head>
        <body>
            <h1>Welcome to our Edit Client page</h1>
            <form id = "form" action="/editClient.asp">
                    Name: <input type="text" name = "name" id = "name" value="<%response.write RS(1)%>">
                    Date Of Birth: <input type="text" name = "DoB" id = "DoB" value="<%response.write RS(2)%>">
                    Phone Number: <input type="text" name = "phone" id = "phone" value="<%response.write RS(3)%>">
                    <input type="hidden" name = "Action" value = "Create">
                    <input type="hidden" name = "ID" value = "<%=request("ID")%>">
            </form>
            <button onclick="submit();">Submit</button>

            <p>Click to return to the Client page.</p>
            <button id = "Client">Client</button>
        </body>
</html>
