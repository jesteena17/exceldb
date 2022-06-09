<cfcomponent>

  <cffunction  name="uploadfile" returntype ="struct" output="false">
 
 <cfset local.thisPath=expandPath('.')& '/' >
            <cfset local.f_dir=GetDirectoryFromPath(local.thisPath)>
            <cffile action="upload" destination="#local.f_dir#" filefield="fileInput" result="upload" nameconflict="makeunique">
         
            <cfif upload.fileWasSaved>

          <cfset local.myfile = upload.serverDirectory & "/" & upload.serverFile>
                <cfif isSpreadsheetFile(local.myfile)>
                 <cfspreadsheet action="read" src="#local.myfile#" query="importdata" headerrow="1" />
 
 <cfset failedimports = ArrayNew(1)/> 
 <cfset rdata = structNew() />
 <cfset validationerr=ArrayNew(1)/>
 <cfset error1=""/> <cfset error2=""/> <cfset error3=""/>
 
<cfloop query="importdata" startrow="2">

 
 <cfif Len( product_title ) GT 0 and not isValid("regex", product_title, "^[a-zA-Z0-9]*$") >
 
      <cfset error1 &="name can only letters and numbers"/>
       
     <cfelse>
     <cfset error1 &="name canot be empty"/>
     
</cfif>
     <cfif Len( product_code ) GT 0 and  not isValid("regex", product_code, "^[a-zA-Z0-9]*$")>
        
      <cfset error2&="pcode  can only letters and numbers"/>
       
       <cfelse>
     <cfset error2&="code canot be empty"/>
       
     </cfif>
   <cfif Len( product_price ) GT 0 and not isValid("regex", product_price, "^[0-9]*$")>
     
      <cfset error3&="price must be a number"/>
      
       <cfelse>
     <cfset error3&="price canot be empty"/>
      
     </cfif>
   
  <cfif not error1 eq "" || not error2 eq ""|| not error3 eq "">
  <cfset  arrayAppend( failedimports , product_code ) />
   <cfset arrayAppend(validationerr,error1)/>
    <cfset arrayAppend(validationerr,error2)/>
     <cfset arrayAppend(validationerr,error3)/>
  <cfelse>

 <cfset rdata['msg']="valid success"/>
    <cftry>
      <cfquery  result="foobar">
        replace  INTO products
        (
          product_title
          , product_code
          , product_price
        )
        VALUES
        (
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_title#" />
          , <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_code#" />
          , <cfqueryparam cfsqltype="cf_sql_double" value="#product_price#" />
        )
      </cfquery>

      <cfcatch type="any">
        <cfset  arrayAppend( failedimports, product_code) />
      </cfcatch>
    </cftry>
  </cfif>
</cfloop>
 


 
  <cfif arrayLen( failedimports)>
  
 <cfset rdata['msg']=arrayLen( failedimports )&"products could not be imported">
   <!--- <cfloop list="#rdata["failedimports"]#" index="index">
      #index#<br />
    </cfloop>--->
  <cfelse>
    <cfset rdata['msg']="no products missed to import">
  </cfif>


  <cfelse>
                    <cfset rdata["errors"] = "The file you uploaded was not an Excel file.">
                    <cffile action="delete" file="#local.myfile#">
                </cfif>
            <cfelse>
                <cfset rdata["errors"] = "The file was not uploaded.Please choose a file">	
            </cfif>
       <cfset rdata["failedimports"]=failedimports/>
        <cfset rdata['valerrmsg']=validationerr/>
            <cfreturn rdata/>
	</cffunction>
   <cffunction  name="getAllProductData" returntype ="query" output="false">
        <cfquery name="getAllProducts">
            SELECT * from Products;
        </cfquery>
        <cfreturn getAllProducts>
    </cffunction>
</cfcomponent>