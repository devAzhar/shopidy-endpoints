<!-- #include file ="common-functions.asp" -->
<% 
Dim dteFrm
 dteFrm = Date()
 dteFrm = DateAdd("d", dteFrm, -365)

 minF = Minute(Now())-20
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
 dteTo = DateAdd("d", dteTo, -365)

 d = split(DateAdd("d",1,dteTo),"/")
 dTo = d(2) & "-" & d(0) & "-" & d(1) & " "  & Hour(Now()) & ":" & minT & ":00"
 
 'response.write dFrm & "<br>"
 'response.write dTo & "<br>"

'https://novel-concept-designs.myshopify.com/admin/orders.json?created_at_min=2016-07-29&created_at_max=2016-07-30&fields=id,email,customer
'Response.Write("https://a9e15a42a92b29c9e707ce216dbce47a:bef61b5f0e19c9c8f23df5a597da7913@novel-concept-designs.myshopify.com/admin/orders.json?created_at_min="&dFrm&"&created_at_max="&dTo&"&fields=id,email,customer")
api_response = proxyAPICall("https://a9e15a42a92b29c9e707ce216dbce47a:bef61b5f0e19c9c8f23df5a597da7913@novel-concept-designs.myshopify.com/admin/orders.json?created_at_min="&dFrm&"&created_at_max="&dTo&"&fields=id,email,customer")

json_response = "Hola!"
json_response = api_response


'Call Response.AddHeader("Access-Control-Allow-Origin", "*")

'Response.ContentType = "application/json"
Response.Write(json_response)

'Response.Write txt
Response.End


%>