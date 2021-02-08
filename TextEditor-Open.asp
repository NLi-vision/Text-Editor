<%
	' server-side page to get the JSON object(filename) sent from the POST
	' and parse it and open the file, parse the content of the file to JSON 
	' format and send back to client-side.	
	
	dim filename,content
	' get file name from client-side
	filename=Request.Form("filename")
	set fs=Server.CreateObject("scripting.filesystemobject")
	set txt=fs.OpenTextFile(Server.MapPath("/MyFiles/"&filename),1,true)
	' read all content from the file
	content=txt.ReadAll
	' make the content to JSON format
	jsonContent="{ ""content"": """&content&""" }"
	' send content back to client-side
	response.write (jsonContent)
	txt.Close
	set txt=nothing		
	set fs=nothing
%>
