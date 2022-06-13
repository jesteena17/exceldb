  <cfoutput>
    

<cfdump var=#Server.Coldfusion.SupportedLocales#/>

<cfset javalocale = createObject("java", "java.util.Locale")/>
<cfset javarb = createObject("java", "java.util.ResourceBundle")/>
<cfdump var=#javarb#/>
  
 <cfset SetLocale("hi_IN")/>  Message in #GetLocale()#
  <cfset bundle = javarb.getBundle("MessageBundle")/>
  Message in #GetLocale()# #bundle.getString("greeting")#  

    </cfoutput>