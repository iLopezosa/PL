%%
%unicode
// %debug
%type String
%{
  int lines = 0;
  int words = 0;
  int chars = 0;
%}
%eofval{
  return "\t" + lines + "\t" + words + "\t" + chars;
%eofval}

%%
// Linea
\R
{
  lines++;
  chars++;
}
// Palabra
[^\s]+
{
  words++;
  chars += yytext().length();
}
// Caracter
[^]
{
  chars++;
}