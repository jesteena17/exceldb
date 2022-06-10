
<cfcomponent>

  <cffunction  name="uploadfile" returntype ="struct" output="true" access="remote">
        <cfset returndata=StructNew()/>
      
        <cfset errors=""/>
        <cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>

            <!--- Destination outside of web root --->
            <cfset dest = getTempDirectory()>

            <cffile action="upload" destination="#dest#" filefield="xlsfile" result="upload" nameconflict="makeunique">

                        <cfif upload.fileWasSaved>
                            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
                            <cfif isSpreadsheetFile(theFile)>
                                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                                <!---	<cffile action="delete" file="#theFile#"> --->
                                    
                                    <cfset metadata = getMetadata(data)>
                                    <cfset colList = "">
                                    <cfloop index="col" array="#metadata#">
                                        <cfset colList = listAppend(colList, col.name)>
                                    </cfloop>
                                 
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
                                                    
                                                        <cfset rowValidationError = true>
                                                        <cfset rowValidationErrorMsg = '<br>product title can only have alphabets and numbers in row '& row &' column '&col>
                                                    </cfif>
                                                </cfif>
                                                <cfif listGetAt(colList, col) eq 'product_price'>
                                                    <cfif !isValid("regex", data[listGetAt(colList, col)][row], "^[a-zA-Z0-9]*$")>
                                                    
                                                        <cfset rowValidationError = true>
                                                        <cfset rowValidationErrorMsg = '<br>product price must be number in row '& row &' column '&col>
                                                    </cfif>
                                                </cfif>

                                                <cfif hadStuff and not rowValidationError and rowValidationErrorMsg eq "">
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
                                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#data['product_title'][row]#" />
                                                            , <cfqueryparam cfsqltype="cf_sql_varchar" value="#data['product_code'][row]#" />
                                                            ,<cfqueryparam cfsqltype="cf_sql_double" value="#data['product_price'][row]#"/>
                                                            )
                                                        </cfquery>

                                                        <cfcatch type="any excpt">
                                                        
                                                            <cfset errors= excpt.Message/>
                                                        </cfcatch>
                                                        </cftry>
                                                <cfelse>
                                                       <cfset errors= rowValidationErrorMsg/>
                                                </cfif>
                                        </cfloop>
                                    </cfloop>
                            </cfif>

                <cfelse>
                    <cfset errors = "The file was not an Excel file.">
                   
                <!---	<cffile action="delete" file="#theFile#"> --->
                </cfif>
            <cfelse>
               
                <cfset errors = "The file was not properly uploaded.">	
            </cfif>
         
          <cfset returndata['errors'] = errors>
<cfif errors eq "">
<cfset returndata['message'] = "Data Saved Successfully">
<cfelse>
<cfset returndata['message'] = "Some Error Occured While Saving Data">
</cfif>
        
          
    <cfreturn returndata/>
</cffunction>

<cffunction  name="getAllProductData" returntype ="query" output="false">
        <cfquery name="getAllProducts">
            SELECT * from Products order by added_at desc;
        </cfquery>
        <cfreturn getAllProducts>
    </cffunction>

</cfcomponent>
