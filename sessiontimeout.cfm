<!--- Minutes into MS ---> 
<cfset sessionTimeout = 2> <html>
<head> <title>Timeout Example</title>

<script> 
<cfoutput>
 var #toScript((sessionTimeout-1)*60*1000,"sTimeout")# </cfoutput> 
setTimeout('sessionWarning()', sTimeout);

function sessionWarning() 
{ 
    alert('Hey ,your session is going to time out unless you do something!');
 } 
</script>

</head>

<body>

</body> </html>