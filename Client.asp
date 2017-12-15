<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
        </style>

        <script type="text/javascript">
            window.onload = function(){
                document.getElementById("Main").onclick = function () {
                    location.href = "./main.asp"
                };
                document.getElementById("addClient").onclick = function () {
                    location.href = "./newClient.asp"
                }; 
            };
            function redirect (ID) {
                location.href = "./editClient.asp?ID="+ID
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
        cmd.CommandText = "[dbo].[spClientSelect]"
        cmd.CommandType = 4  'adCmdStoredProc 
        
        'Execute the stored procedure
        SET RS = cmd.Execute
        SET cmd = Nothing
        %>
    </head>
    <body>
        <h1>Welcome to our Clients page</h1>
        <table>
            <tr id = "headers">
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Phone Number</th>
                <th>Edit</th>
            </tr>
        <%
        'You can now access the record set
        WHILE NOT RS.EOF
            response.write "<tr class ='data'>"
            response.write "<td>"+RS(1)+"</td>"
            response.write "<td>"+RS(2)+"</td>"
            response.write "<td>"+RS(3)+"</td>"
            response.write "<td><button onclick=""redirect("&RS(0)&")"">edit</button></td></tr>"
            RS.Movenext
        WEND
        %>
        </table>
        <p>Click to return to the Main page.</p>
        <button id = "Main">Main</button>
        <p>Add a new client.</p>
        <button id = "addClient">Add Client</button>

    </body>
</html>