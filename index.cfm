<cfset showMessage = false>
<cfif structKeyExists(form, "fileInput") and len(form.fileInput)>
    <cfinvoke component="test"  method="uploadfile" returnvariable="resultedXlsxData" >
      <cfinvokeargument  name="formValue"  value="#form#">
    </cfinvoke>
    <cfdump var=#resultedXlsxData#/>
    <cfset showMessage = true>
</cfif>
<cfinvoke component="test"  method="getAllProductData" returnvariable="allUsers" >
</cfinvoke>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excel Manager</title>
  
    <link rel="stylesheet" href="bootstrap.min.css">
</head>
<body>
    <cfoutput>
        <section>
            <div class="d-flex justify-content-around mt-5 p-3">
              
                <div class="col">
                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col d-flex justify-content-center">
                                <label for="fileInput" class="btn btn-dark">
                                    <input type="file" name="fileInput" id="fileInput" >
                                    Browse
                                </label>
                            </div>
                            <div class="col d-flex justify-content-center">
                                <button type="submit" class="btn btn-success" >Upload</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <table class="table table-bordered bg-light m-5">
                    <thead>
                        <tr>
                            <th>product Name</th>
                            <th>product_code</th>
                            <th>price</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="allUsers">
                            <tr>
                                <td>#product_title#</td>
                                <td>#product_code#</td>
                                <td>#product_price#</td>
                                
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </div>
        </section>
        <section>
         
            
            <cfif structKeyExists(url, 'success')> 
                <cfif structKeyExists(session, 'success')> 
                    <cfif session.success>
                        <div class="alert alert-success alert-dismissible d-flex align-items-center" role="alert">
                            <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="##check-circle-fill"/></svg>
                            <div>
                                Product Details Updated Succesfully
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </cfif>
                </cfif>
            </cfif>
            <cfif showMessage>
                <cfif structKeyExists(resultedXlsxData, 'success')> 
                    <cfif !resultedXlsxData.success>
                        <div class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
                            <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="##exclamation-triangle-fill"/></svg>
                            <div>
                                #resultedXlsxData.errors#
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </cfif>
                </cfif>
            </cfif>
        </section>
        
    </cfoutput>
</body>
</html>