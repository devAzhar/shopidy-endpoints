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





Dim dteFrm
 dteFrm = Date()
 dteFrm = DateAdd("d", dteFrm, -1085)

 minF = Minute(Now())-17
 minT = Minute(Now())

 if len(minF) < 2 then
    minF = "0"&minF
 end if

  if len(minT) < 2 then
    minT = "0"&minT
 end if

 d = split(DateAdd("d",1,dteFrm),"/")
 dFrm = d(2) & "-" & d(0) & "-" & d(1) & " " & Hour(Now()) & ":" & minF & ":00"

Dim dteTo
 dteTo = Date()
 dteTo = DateAdd("d", dteTo, -1085)

 d = split(DateAdd("d",1,dteTo),"/")
 dTo = d(2) & "-" & d(0) & "-" & d(1) & " "  & Hour(Now()) & ":" & minT & ":00"
 '

'https://novel-concept-designs.myshopify.com/admin/orders.json?created_at_min=2016-07-29&created_at_max=2016-07-30&fields=id,email,customer
Response.Write("https://a9e15a42a92b29c9e707ce216dbce47a:bef61b5f0e19c9c8f23df5a597da7913@novel-concept-designs.myshopify.com/admin/orders.json?created_at_min="&dFrm&"&created_at_max="&dTo&"&fields=id,email,customer <hr/>")
api_response = proxyAPICall("https://a9e15a42a92b29c9e707ce216dbce47a:bef61b5f0e19c9c8f23df5a597da7913@novel-concept-designs.myshopify.com/admin/orders.json?created_at_min="&dFrm&"&created_at_max="&dTo&"&fields=id,email,customer")

json_response = "Hola!"
json_response = api_response


'Call Response.AddHeader("Access-Control-Allow-Origin", "*")

'Response.ContentType = "application/json"
Response.Write(json_response)

'Response.Write txt
Response.End


%>