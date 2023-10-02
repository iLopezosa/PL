%%
%unicode
%int
%{
  int suma = 0;
%}
%eof{
  if (Suma.out != System.out) {
    System.out.println("Suma: " + suma);
  }
  Suma.out.println("Suma: " + suma);
%eof}
%%
[0-9]+    { suma += Integer.parseInt(yytext()); }
[^]       { /* ignore */ }