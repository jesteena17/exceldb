
<cfoutput>
<cfset showForm = true>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>

	<!--- Destination outside of web root --->
	<cfset dest = getTempDirectory()>

	<cffile action="upload" destination="#dest#" filefield="xlsfile" result="upload" nameconflict="makeunique">

	<cfif upload.fileWasSaved>
		<cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
		<cfif isSpreadsheetFile(theFile)>
			<cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
		<!---	<cffile action="delete" file="#theFile#"> --->
			<cfset showForm = false>
		<cfelse>
			<cfset errors = "The file was not an Excel file.">
		<!---	<cffile action="delete" file="#theFile#"> --->
		</cfif>
	<cfelse>
		<cfset errors = "The file was not properly uploaded.">	
	</cfif>
		
</cfif>

<cfif showForm>
	<cfif structKeyExists(variables, "errors")>
		<cfoutput>
		<p>
		<b>Error: #variables.errors#</b>
		</p>
		</cfoutput>
	</cfif>
	
	<form action="demo.cfm" enctype="multipart/form-data" method="post">
		  
		  <input type="file" name="xlsfile" required>
		  <input type="submit" value="Upload XLS File">
		  
	</form>
<cfelse>


	
	<p>
	Here is the data in your Excel sheet (assuming first row as headers):
	</p>
	
	<cfset metadata = getMetadata(data)>
	<cfset colList = "">
	<cfloop index="col" array="#metadata#">
		<cfset colList = listAppend(colList, col.name)>
	</cfloop>
	
	<cfif data.recordCount is 1>
		<p>
		This spreadsheet appeared to have no data.
		</p>
	<cfelse>
		
			<cfloop index="c" list="#colList#">
					#c#
				</cfloop> 
		<br>
         <cfset rowValidationError = false>
         <cfset rowValidationErrorMsg ="">
			<cfloop index="row" from="2" to="#data.recordCount#">
				<cfset hadStuff = false>
				
			   <cfloop index="col" from="1" to="#listLen(colList)#">
                 <cfif len(data[listGetAt(colList, col)][row]) GT 0>
<cfset hadStuff = true>
                 </cfif>
        <!---       <cfdump var=#len(data[listGetAt(colList, col)][row])#>   --->
<cfif listGetAt(colList, col) eq 'product_code'>
 <cfif !isValid("regex", data[listGetAt(colList, col)][row], "^[a-zA-Z0-9]*$")>
  
     <cfset rowValidationError = true>
      <cfset rowValidationErrorMsg = '<br>product code can only have alphabets and numbers in row '& row &' column '&col>
 </cfif>
</cfif>
<cfif listGetAt(colList, col) eq 'product_title'>
 <cfif !isValid("regex", data[listGetAt(colList, col)][row], "^[a-zA-Z0-9]*$")>
    hi error
     <cfset rowValidationError = true>
      <cfset rowValidationErrorMsg = '<br>product title can only have alphabets and numbers in row '& row &' column '&col>
 </cfif>
</cfif>
<cfif listGetAt(colList, col) eq 'product_price'>
 <cfif !isValid("regex", data[listGetAt(colList, col)][row], "^[a-zA-Z0-9]*$")>
    hi error
     <cfset rowValidationError = true>
      <cfset rowValidationErrorMsg = '<br>product price must be number in row '& row &' column '&col>
 </cfif>
</cfif>
 <cfif not rowValidationError and rowValidationErrorMsg eq "">
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
failed to import #row#
      </cfcatch>
    </cftry>
</cfif>
				</cfloop>
					
			</cfloop>
	
	</cfif>
	
</cfif>

	</cfoutput>