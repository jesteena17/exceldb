request<cfdump var="#request#"/><br>

session<cfdump var="#session#"/>
<br>
cgi<cfdump var="#cgi#"/>
<br>url
<cfdump var="#url#"/><br>variables
<cfset local.name="anu">
<cfset request.age="12">
<cfset fileInput=10/>
<cfdump var="#variables#"/><br>

<form action="" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col d-flex justify-content-center">
                                <label for="fileInput" class="btn btn-dark">
                                    <input type="text" name="fileInput" id="fileInput" >
                                    Browse
                                </label>
                            </div>
                            <div class="col d-flex justify-content-center">
                                <button type="submit" class="btn btn-success" >Upload</button>
                            </div>
                        </div>
                        </form>

                        <br>fileInput value=

                        <cfdump var=#form.fileInput#/>
<br>
                        request<cfdump var="#request#"/><br>
                       request val <cfdump var="#request.age#"/><br>