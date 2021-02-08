<!DOCTYPE html>
<!-- 
	Author: Ning Li
	Date: Dec 12, 2020
	Description: this page is a server-side ASP page, the server get the files list 
                 and send the page back to client-side. 	
-->

<html>
	<head>
		<title>Online Text Editor</title>
		<style type="text/css">
        .style1 
        {
            text-align: center;
			color:Indigo
        }
		</style>	
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		 
	$(document).ready(function(){		
		$("#openFile").click(function(){
			// get the selected file name and send to server-side
			var options=$("#fileList option:selected");
			var fileName=options.text();
			$.post("TextEditor-Open.asp",
			  {
				//JSON format of file name
				filename: fileName			
			  },
			  // callback from the server-side
			  function(data, status){
				//parse the data from server and remove 'enter' from the string
				var myObj = JSON.parse(data.replace(/[\r\n]/g,""));
				document.getElementById("fileview").innerHTML =myObj.content;				
			});					
		});
		
		// save the text to server
		$("#saveFile").click(function(){
			var options=$("#fileList option:selected"); 
			var fileName=options.text();
			var contentText=document.getElementById("fileview").value;			
			$.post("TextEditor-Save.asp",
			  {
				// JSON format of file name and content
				filename: fileName,
				content: contentText
			  },
			  // callback and alert function
			  function(data, status){			    
				 alert("Save File Status: " + status);
			  });
	 	});
	});
	
	// this function used for save the text in textarea box as a new file		
	function SaveAs() 
	{
		// get new file name from prompt
		var fileName = prompt("Please enter new filename");
		var contentText=document.getElementById("fileview").value;
		if ((fileName.trim()).length != 0) {		
		$.post("TextEditor-Save.asp",
			  {
				// JSON format of file name and content
				filename: fileName,
				content: contentText
			  },
			  function(data, status){			    
				 alert("Save File Status: " + status);
			  });
		}
		else
		{
			alert("Filename can not be blank!");
		}
	} 	
	
	</script>		
	
	
	<body style="background-color:DarkGray;">
	<H2 class="style1">SET Online Text Editor</H2>
	<hr/>
	
	<table border="0" width="90%">
		<tr>
          <td width="38%" align="right">Select a file from <b>MyFiles</b> folder:</td>
          <td width="1%">&nbsp;</td>
          <td width="51%" align="left">
		  <select id="fileList" name="fileList">
				<option value="0"checked> </option>
			  <%
			    ' serverside code to get the filenames in the MyFiles folder
			    dim objf, filepath
				set fso=server.createobject("scripting.filesystemobject")
				filepath=server.mappath("\MyFiles") 
				set f=fso.GetFolder(filepath)
				For Each objf in f.Files				
				response.write "<option value="&objf.name&">"&objf.name&"</option><br/>"				
				next				
				set fso=nothing
				set f=nothing
			  %>                            
            </select>
			&nbsp;&nbsp;<button id="openFile">Open</button>
		  </td>
         
        </tr>		
	</table>
	<br/>
	
	<div align="center">		 
		<textarea id="fileview" name="fileview" rows="20" cols="100" ></textarea>
	</div>
	<br/>
	
	<table border="0" width="90%">
		<tr>
          <td width="40%" align="right"><button id="saveFile">Save</button></td>
          <td width="50" align="center"><button onclick="SaveAs()" id="saveAs">Save as</button></td>
		</tr>		
	</table> 	
	</body>
</html>