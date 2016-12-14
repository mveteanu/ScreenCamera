<%@ Language=VBScript %>
<%
Const DLL_BASE = "/scripts/screencapture.dll"
dim imgsrc,imgstr

if Request.QueryString("mov")<>"" then 
  printmov
  Response.End 
end if  

if Request.Form.Count=0 then
  printform
else
  getimgstr imgsrc, imgstr
  if Request.Form("displaytype")="img" then
     printimg
  else
     Session("imgsrc")=imgsrc
     Session("imgstr")=imgstr
     printframeindex
  end if      
end if  
 
sub getimgstr(ByRef Srci, ByRef Stri)
  dim imgstr1,imgstr2,w,h,ws,hs,c,cs
  imgstr1 = DLL_BASE
  imgstr2= ""
  ws = Request.Form("width")
  hs = Request.Form("height")
  cs = Request.Form("compr")
  w = 0
  h = 0
  c = 100
  if isnumeric(cs) then c = Abs(CInt(cs))
  if c>100 then c = 100
  imgstr1 = imgstr1 & "?compr="&c
  if isnumeric(ws) then w = Abs(CInt(ws))
  if isnumeric(hs) then h = Abs(CInt(hs))
  if Request.Form("resize")="2" then 
     imgstr1 = imgstr1 & "&width="&w & "&height="&h
  else
     if w<>0 then imgstr2 = "width="&w
     if h<>0 then imgstr2 = imgstr2 & " height="&h
  end if   
  if Request.Form("time")="yes" then imgstr1 = imgstr1 & "&time=yes"
  Srci = imgstr1
  Stri="<img id=screenimg src='"& imgstr1 &"' " & imgstr2 & " >"
end sub


sub printform
%>
<html>
<head>
<title>Desktop through web</title>
<style>
 .texte { color: #000090; font-size: 10px; font-family: Verdana }
 .titlu { color: #000090; font-size: 20px; font-family: Verdana }
 .but   { color: #000090; font-size: 10px; font-family: Verdana; width:100; cursor: hand;}
 .input { color: #000090; font-size: 10px; font-family: Verdana; width:80; border: 1px solid black;}
 a      { color: #000090; text-decoration: none; font-weight:bold;}
 a:hover{ color: red; text-decoration:underline;}
</style>
</head>

<body>

<script language=javascript>
 function viewhelp(a)
  {
    switch(a)
     {
       case 1: alert("Specificati lungimea in pixeli a imaginii.\nImplicit aceasta este lungimea ecranului.");
               break;
       case 2: alert("Specificati inaltimea in pixeli a imaginii.\nImplicit aceasta este inaltimea ecranului.");
               break;
       case 3: alert("Specificati unde se face redimensionarea imaginii.");
               break;
       case 4: alert("Specificati in procente factorul de compresie a imaginii JPEG\nImplicit este 100 adica calitate maxima, compresie minima");
               break;
       case 5: alert("Specificati daca doriti afisarea orei serverului peste imagine.");
     }
  }
  
 function submitclick(a)
  {
    if (a==1) 
     { 
       mainform.displaytype.value = "img";
       mainform.target = "_top";
     }  
    else 
     {
       open("","fullscreen","fullscreen=yes, toolbar=no, menubar=no, location=no, status=no");
       mainform.displaytype.value = "mov";
       mainform.target = "fullscreen";
     }  
    mainform.submit();
  }
</script>

<form name="mainform" method="post" action="default.asp">
<input type="hidden" name="displaytype">
<table border=0 width=300 align=center cellpadding=5 cellspacing=0 class=texte style="border: 1px solid black; background-color:#639CCE;">
<tr>
 <td colspan=3 align=center><span class=titlu title="(c) VMAsoftware http://vmasoft.hypermart.net">Desktop through Web</span></td>
</tr>
<tr>
 <td align=left width=80>
   Width:
 </td>
 <td align=center width=160>
   <input type="text" name="width" size=6 maxlength=4 class="input">
 </td>
 <td align=left width=60><a href="javascript:viewhelp(1)">?</a></td>
</tr>
<tr>
 <td align=left>
   Height:
 </td>
 <td align=center>
   <input type="text" name="height" size=6 maxlength=4 class="input">
 </td>
 <td align=left><a href="javascript:viewhelp(2)">?</a></td>
</tr>
<tr>
 <td align=left>
   Resize:
 </td>
 <td align=center>
   <select name="resize" class="input"><option selected value="1">On client</option><option value="2">On server</option></select>
 </td>
 <td align=left><a href="javascript:viewhelp(3)">?</a></td>
</tr>
<tr>
 <td align=left>
   Compress:
 </td>
 <td align=center>
   <input type="text" name="compr" size=6 maxlength=3 class="input">
 </td>
 <td align=left><a href="javascript:viewhelp(4)">?</a></td>
</tr>
<tr>
 <td align=left>
   Write time:
 </td>
 <td align=center>
   <select name="time" class="input"><option value="yes">Yes</option><option selected value="no">No</option></select>
 </td>
 <td align=left><a href="javascript:viewhelp(5)">?</a></td>
</tr>
<tr>
 <td colspan=3 align=center>
   <input type="button" onclick="submitclick(1)" name="submitimg" value="Desktop Image" title="Vizualizarea unei singure capturi de ecran de pe server" class="but">
   <input type="button" onclick="submitclick(2)" name="submitmov" value="Desktop Movie" title="Vizualizarea continua a ecranului serverului" class="but">
 </td>
</tr>
</table>
</form>

</body>
</html>
<%
end sub

sub printimg
Response.Expires = 0
%>
<html>
<head>
<title>Desktop through web</title>
<style>
 .texte { color: #000090; font-size: 10px; font-family: Verdana }
 .titlu { color: #000090; font-size: 20px; font-family: Verdana }
 .but   { color: #000090; font-size: 10px; font-family: Verdana; width:100; cursor: hand;}
 .input { color: #000090; font-size: 10px; font-family: Verdana; width:80; border: 1px solid black;}
 a      { color: #000090; text-decoration: none; font-weight:bold;}
 a:hover{ color: red; text-decoration:underline;}
</style>
</head>

<script language=javascript>
  function backbut() { window.location.href = "default.asp" ; } 
  function refresh() { screenimg.src = "<%=imgsrc%>" ; }
</script>

<body>
  <table border=0 width=300 align=center cellpadding=5 cellspacing=0 class=texte style="border: 1px solid black; background-color:#639CCE;">
   <tr><td width=100% align=left>
     <span class="titlu">Desktop through web</span><br>
     Server name: <%=Request.ServerVariables("SERVER_NAME")%><br>
     Server soft: <%=Request.ServerVariables("SERVER_SOFTWARE")%><br>
     Server time: <%=FormatDateTime(Now(),vbGeneralDate)%><br>
   </td></tr>
   <tr><td width=100% align=center>
     <input type="button" value="Refresh" class="but" onclick="javascript:refresh()">
     <input type="button" value="Back" class="but" onclick="javascript:backbut()">
   </td></tr>
  </table>
  <br><br>
  <center><%=imgstr%></center>
</body>
</html>
<%
end sub

sub printmov
Response.Expires = 0
%>
 <body TOPMARGIN=0 LEFTMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
  <script language=vbscript> 
    sub screenimg_onload
      screenimg.src = "<%=Session("imgsrc")%>"
    end sub
  </script>
  
  <table width=100% height=100% border=0 cellspacing=0 cellpadding=0>
  <tr><td align=center valign=center>
    <%=Session("imgstr")%>
  </td></tr>
  </table>
 </body>
<%
end sub

sub printframeindex
 with Response
  .Write "<frameset rows='*,0' border=0 frameBorder=No frameSpacing=0 marginwidth=0 Marginheight=0>"
  .Write "<frame name='screen' src='default.asp?mov=yes' scrolling='no' frameborder=0 marginwidth=0 Marginheight=0 frameSpacing=0 noresize>"
  .Write "</frameset>"
 end with
 Response.End 
end sub
%>