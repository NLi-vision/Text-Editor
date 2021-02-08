<%
	' server-side page to get the JSON object sent from the client-side
	' and parse it and save the content to the file.
	dim filename,content,filepath
	' get file name and content from client-side
	filename=Request.Form("filename")
	content=Request.Form("content")
	filepath=server.mappath("\MyFiles")
	Set fs=Server.CreateObject("Scripting.FileSystemObject")	
	Set fo=fs.GetFolder(filepath)
	Set tfile=fo.CreateTextFile(filename)
	' send content back to client-side
	tfile.WriteLine(content)	
	tfile.Close
	set tfile=nothing	
	set fo=nothing
	set fs=nothing
%>