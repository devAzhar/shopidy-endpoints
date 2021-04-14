<%
Function proxyAPICall(URL)
    'On Error Resume Next

	'create ajax request
	Set xmlHttp = Server.Createobject("MSXML2.ServerXMLHTTP")
    Set xmlHttp = Server.Createobject("MSXML2.XMLHTTP")
    'Set xmlHttp = Server.Createobject("MSXML2.XMLHTTP.6.0")
    'Set xmlHttp = Server.Createobject("WinHTTP.WinHTTPRequest.5.1")
    'Set xmlHttp = Server.CreateObject("MSXML2.XMLHTTP.6.0")

	xmlHttp.Open "GET", URL, False, "a9e15a42a92b29c9e707ce216dbce47a", "bef61b5f0e19c9c8f23df5a597da7913"
	xmlHttp.setRequestHeader "Authorization", "Basic AUTH_STRING"
    xmlHttp.setRequestHeader "User-Agent", "asp httprequest"
	xmlHttp.setRequestHeader "content-type", "application/x-www-form-urlencoded"
	'send the http get ajax
	xmlHttp.Send
	If Err.number <> 0 then
      writeGenericDebugLogEntry "xmlHttp_get url:" & URL,"Error retrieving api response", 0, Err.number,Err.description
      Response.Write("ERR:" & Err.number)
      Response.End
	End If
	http_response = xmlHttp.responseText
	xmlHttp.abort()
	'cleanup the object
	set xmlHttp = Nothing

   ' Set reg_server = JSON.parse(regserver_json_response)
   ' getAgentRegisterServer = reg_server.server.hostname
   proxyAPICall = http_response

	'on error goto 0
End Function 
%>