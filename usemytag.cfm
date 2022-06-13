call custom tag either using cf_tagnam like below
<br>
<cf_happybirthdaytag param1="arun" wishes="gmng">
<br>
or using cf module tag <br>
<cfset attr={param1="rinu",wishes="returns of the day"}/>
<cfmodule template = "happybirthdaytag.cfm" attributeCollection=#attr#>

<br>
both abv methd  work only if the custom atg file is in the root folder<br>
=======================
<br>

<cfimport prefix="bdaytag" taglib="./customtags">
<bdaytag:happybirthdaytag param1="anu" msg="hapybirthday" >

<br>
<cf_testtag name="Pete">