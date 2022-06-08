<%@ page language="java"  import="WSClientHelper%>
<%
   String url = request.getParameter("svrUrl");
   String input_xml = request.getParameter("input_xml");
   String output_xml = "";

   if(url != null && !url.trim().equals("")){
	   WSClientHelper client = new WSClientHelper(url,input_xml,false);
	   output_xml = client.triggerTransactionStr();
   }

%>

<html>

<head>
<title>
	SOAP client Simulator
</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<script language="Javascript">
function checkParam()
{
	if(document.toolsForm.svrUrl.value==""){
		alert("Target URL can't be empty");
		return false;
	}
	if(document.toolsForm.input_xml.value==""){
		alert("Input xml can't be empty");
		return false;
	}

	document.toolsForm.submit();
}

</script>

</head>
<body>

<jsp:include page="ToolsTitle.jsp" flush="true"/>
<table width="100%" border="0">
<tr valign="top"><td width="120" bgcolor="#eeeeff">
<jsp:include page="ToolsNav.jsp" flush="true"/>
</td><td>

<center><h2><u><strong>SOAP client simulator</strong></u></h2></center>
<br />
<form name="toolsForm" method="post">
<input type="hidden" name="ACTION_KEY">
<input type="hidden" name="iType">
<p class="contentText2"><b>Target URL:</b> <input type="text" name="svrUrl" value="<%=url%>" size="100" maxlength="100"/>
<br>e.g. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;: http://dbr5wb01.mt.att.com:9001/servlet/rpcrouter
</p>
<% if (output_xml != null && output_xml.startsWith("Error") ) { %>
<b><font color="red">Error Occured:</font> </b><br/>
<p class="contentText2">
<font color="red"><%=output_xml%></font>
</p>
<%output_xml="";%>
<% } %>
<hr>
<table class="contentText2" border="1">
<tr valign="top">
	<td align><b><CENTER>XML input:</CENTER></b><br><CENTER>(Scroll below for an example)</CENTER></td>
	<td><b><CENTER>XML output:</CENTER></b></td>
</tr>
<tr>
	<td><textarea name="input_xml" cols="50" rows="30"><%=input_xml%></textarea></td>
	<td><textarea name="output_xml" cols="50" rows="30"><%=output_xml%></textarea></td>
</tr>
<tr align="center">
	<td colspan="2"><input type="button" value="Trigger Transaction" onClick="checkParam();"></td>
</tr>
<tr align="left">
	<td colspan="2">
	<b>Example XML input:</b>
	<br>&lt;?xml version='1.0' encoding='UTF-8'?&gt;
	<br>&lt;SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"&gt;
	<br>
	<br>&nbsp;&nbsp;&lt;SOAP-ENV:Header&gt;&lt;/SOAP-ENV:Header&gt;
	<br>&nbsp;&nbsp;&lt;SOAP-ENV:Body&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&lt;ns1:processMessage xmlns:ns1="urn:Service" SOAP-ENV:encodingStyle="http://xml.apache.org/xml-soap/literalxml"&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;message&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;createdABProject&gt;
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;MDSNumber&gt;CR720-101&lt;/MDSNumber&gt;
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;CProjectNumber&gt;C10665617&lt;/CProjectNumber&gt;
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ServiceType&gt;6&lt;/ServiceType&gt;
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;GroupId&gt;AGID288&lt;/GroupId&gt;
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;requestId&gt;CC1019668089&lt;/requestId&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/createdABProject&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/message&gt;
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ns1:processMessage&gt;
	<br>&nbsp;&nbsp;	&lt;/SOAP-ENV:Body&gt;
	<br>&lt;/SOAP-ENV:Envelope&gt;
	</td>
</tr>
</table>
</form>

</td></tr>
</table>

</body>
</html>

