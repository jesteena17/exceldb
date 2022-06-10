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
    </cfscript>

    