%%
%unicode
// %debug
%int
%{
  // Init vars
%}
%eof{
  System.out.print(WikiCrawler.nImg);
%eof}

// CONSTANTS
img = img

// STATES

%%
{img} {
  WikiCrawler.nImg++;
}
// <YYINITIAL> {
//   //  Assignation
//   {ID}=
//   {
//     id = yytext().split("=")[0];
//     yybegin(ASSIGN);
//   }
//   // Command
//   "echo "
//   {
//     result.append("echo ");
//     yybegin(COMMAND);
//   }
//   // End of command, assignation or string
//   {EOC}
//   {
//     tablaSimbolos.put(id, value.toString());
//     id = "";
//     value = new StringBuffer();
//     string = new StringBuffer();
//   }
//   // Any character
//   [^]
//   {}
// }

// <ASSIGN> {
//   \" // Start of string
//   {
//     yybegin(ASSIGN_STRING);
//   }
//   // Normal value with possible escape characters
//   ([a-zA-Z0-9_=*+-/]|\\.)+
//   {
//     value.append(yytext());
//   }
//   // Variable
//   \${ID}
//   {
//     value.append(tablaSimbolos.get(yytext()));
//   }
//   // End of assignation
//   {EOC}
//   {
//     tablaSimbolos.put(id, value.toString());
//     id = "";
//     value = new StringBuffer();
//     yybegin(YYINITIAL);
//   }
//   // Any character
//   [^]
//   {}
// }

// <COMMAND> {
//   \${ID} // Variable
//   {
//     result.append(tablaSimbolos.get(yytext()));
//   }

//   {EOC} // End of command
//   {
//     result.append(yytext());
//     yybegin(YYINITIAL);
//   }

//   [^] // Any character
//   {
//     result.append(yytext());
//   }
// }

// <ASSIGN_STRING> {
//   \" // End of string
//   {
//     value.append(string.toString());
//     yybegin(YYINITIAL);
//   }

//   \\\" // Escaped double quote
//   {
//     string.append(yytext());
//   }

//   \${ID} // Variable
//   {
//     string.append(tablaSimbolos.get(yytext()));
//   }

//   \\\${ID} // Escaped variable
//   {
//     string.append(yytext());
//   }

//   [^] // Any character
//   {
//     string.append(yytext());
//   }
// }