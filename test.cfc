<cfcomponent>

  <cffunction  name="uploadfile" returntype ="struct" output="false">
 
 <cfset local.thisPath=expandPath('.')& '/' >
            <cfset local.f_dir=GetDirectoryFromPath(local.thisPath)>
            <cffile action="upload" destination="#local.f_dir#" filefield="FileToUpload" result="upload" nameconflict="makeunique">
            <cfif upload.fileWasSaved>
                <cfset local.myfile = upload.serverDirectory & "/" & upload.serverFile>
                <cfif isSpreadsheetFile(local.myfile)>



<cfspreadsheet action="read" src="#ExpandPath( './data.xlsx' )#" query="importdata" headerrow="1" />
 
<!--- <cfset failedimports = "" /> --->
 <cfset rdata = structNew() />
 
<cfloop query="importdata" startrow="2">
 <cfif !Len( product_title ) || !Len( product_code ) || !IsNumeric( product_price )>
    <cfset rdata["failedimports"] = ListAppend( failedimports, product_code ) />
  <cfelse>
    <cftry>
      <cfquery datasource="mydatasource" result="foobar">
        REPLACE INTO users
        (
          product_title
          , product_code
          , product_price
        )
        VALUES
        (
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_title#" />
          , <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_code#" />
          , <cfqueryparam cfsqltype="cf_sql_double" value="#Val( product_price )#" />
        )
      </cfquery>
 
      <cfcatch type="any">
        <cfset rdata["failedimports"] = ListAppend( failedimports, product_code) />
      </cfcatch>
    </cftry>
  </cfif>
</cfloop>
 

  <h1>Failed Imports</h1>
 
  <cfif ListLen( failedimports )>
    <p>#ListLen( failedimports )# products could not be imported.</p>
 
    <cfloop list="#failedimports#" index="index">
      #index#<br />
    </cfloop>
  <cfelse>
    <p>No products failed to be imported.</p>
  </cfif>


  <cfelse>
                    <cfset rdata["errors"] = "The file you uploaded was not an Excel file.">
                    <cffile action="delete" file="#local.myfile#">
                </cfif>
            <cfelse>
                <cfset rdata["errors"] = "The file was not uploaded.Please choose a file">	
            </cfif>
            </cfoutput>
            <cfreturn rdata/>
	</cffunction>
   <cffunction  name="getAllProductData" returntype ="query" output="false">
        <cfquery name="getAllProducts">
            SELECT * from Products;
        </cfquery>
        <cfreturn getAllUsers>
    </cffunction>
</cfcomponent>