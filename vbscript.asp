<html>
    <head>
        <%
        DIM cmd
        SET cmd = Server.CreateObject("ADODB.Command")
        SET cmd.ActiveConnection = Connection
        
        'Set the record set
        DIM RS
        SET RS = Server.CreateObject("ADODB.recordset")
        
        'Prepare the stored procedure
        cmd.CommandText = "[dbo].[sptestproc]"
        cmd.CommandType = 4  'adCmdStoredProc
        
        cmd.Parameters("@Option1 ") = Opt1 
        cmd.Parameters("@Option2 ") = Opt2 
        
        'Execute the stored procedure
        SET RS = cmd.Execute
        SET cmd = Nothing
        
        'You can now access the record set
        if (not RS.EOF) THEN
            first = RS("first")
            second = RS("second")
        end if

        'dispose your objects
        RS.Close
        SET RS = Nothing
        
        Connection.Close
        SET Connection = Nothing
        %>
    </head>

    <select>
        <%response.write "<option Value=" " + RS.ID + " ">" %>
        <option Value="1">
        <option Value="2">
        <option Value="3">
    </select>
</html>