<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<cfoutput>
     <cfinvoke component="demo"  method="getAllProductData" returnvariable="allProducts" >
    </cfinvoke>
 <cfset res="true"/>
    <cfif structKeyExists(form, "submit") >
        <cfinvoke component="demo"  method="uploadfile" returnvariable="res" >
        </cfinvoke>
      
             <cfif structKeyExists(res, "errors")>
                <cfif not res.errors eq "">
                     <p>#res.message#</p>
                <p><b> #res.errors#<br></b> </p>
                <cfelse>
                         <p>#res.message#</p>
                    <cflocation url = "demoindex.cfm" addtoken="no">
                </cfif>
            
            </cfif>
    </cfif>

  
   
     <!---   <cfif showForm>
            --->

        

            <form action="" enctype="multipart/form-data" method="post">
                <input type="file" name="xlsfile" required>
                <input type="submit" name="submit" value="Upload XLS File">
            </form>
       <!--- <cfelse>--->
            <div class="d-flex justify-content-center" id="here">
              
              
                    
                    <table class="table table-bordered bg-light m-5">
                        <thead>
                          <tr>
                               <tr>
                            <th>product Name</th>
                            <th>product_code</th>
                            <th>price</th>
                            
                        </tr>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="allProducts">
                                <tr>
                                    <td>#product_code#</td>
                                    <td>#product_title#</td>
                                    <td>#product_price#</td>
                                    
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
              
            </div>
    <!---    </cfif> --->
</cfoutput>

