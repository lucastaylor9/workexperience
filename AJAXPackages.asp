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

SET ClientID=cmd.CreateParameter ("@ClientID",3,1,,request("ID"))
cmd.Parameters.Append ClientID

'Prepare the stored procedure
cmd.CommandText = "[dbo].[packagefromClient]"
cmd.CommandType = 4  'adCmdStoredProc

'Execute the stored procedure
SET RS = cmd.Execute
SET cmd = Nothing

while not RS.EOF
    response.write RS(0)&","
    RS.movenext
wend
%>