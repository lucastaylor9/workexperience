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
                cmd.CommandText = "[dbo].[spnewClient]"
                cmd.CommandType = 4  'adCmdStoredProc 


                DIM name
                SET name=cmd.CreateParameter ("@name",200,1,30,request("name"))
                cmd.Parameters.Append name

                DIM DoB
                SET DoB=cmd.CreateParameter ("@DoB",133,1,,request("DoB"))
                cmd.Parameters.Append DoB

                DIM phone
                SET phone=cmd.CreateParameter ("@phone",129,1,11,request("phone"))
                cmd.Parameters.Append phone

                'Execute the stored procedure
                SET RS = cmd.Execute
                SET cmd = Nothing
            end if
            %>
        </head>
        <body>
            <h1>Welcome to our Add Client page</h1>
            <form id = "form" action="/newClient.asp">
                    Name: <input type="text" name = "name" id = "name">
                    Date Of Birth: <input type="text" name = "DoB" id = "DoB">
                    Phone Number: <input type="text" name = "phone" id = "phone">
                    <input type="hidden" name = "Action" value = "Create">
            </form>
            <button onclick="submit();">Submit</button>

            <p>Click to return to the Client page.</p>
            <button id = "Client">Client</button>
        </body>
</html>