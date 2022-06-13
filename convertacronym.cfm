	<cfscript>
    function abbreviate( wordin ) {
		var acronym = "";
		var arrayOfWords = listToArray(arguments.wordin, " ,.-_?!':;")
		for (var word in arrayOfWords){
			acronym &= left(word, 1);
		}
		return uCase(acronym);
	}
WriteOutput(abbreviate("cold fusion"));


  function addspace( letter ) {
	    letter = uCase(letter);
		var num = asc( letter ) - asc('A') + 1;
		var result = [];
		var curLetter = '';
	    var padding = num - 1;
	    var center = 0;
	    var resultBottom = [];
		for(var i = 0; i < num; i++){
		    var curLetter = chr(asc('A') + i);
		    result.append( 
		       repeatString(" ", padding)
		       & curLetter
		       & repeatString(" ", center)
		       & (center > 0 ? curLetter : "")
		       & repeatString(" ", padding)
		    );
		    if(i+1!=num){
		        resultBottom.prepend( result[arrayLen(result)] );
		    }
		    padding--;
		    center = ( (num-1)*2+1) - (padding*2) - 2;
		}
		arrayAppend(result, resultBottom, true);
	

	}


    </cfscript>

    <cfoutput>
    <cfset res=ArrayNew(1)/>
    <cfset res=addspace('J')/>
        <cfloop from="1" to="#ArrayLen(res)#" index="i">

    <cfloop from="1" to="#ArrayLen(res[i])#" index="j">
        #r[i][j]#&nbsp;
    </cfloop>
<br>
</cfloop>

    </cfoutput>