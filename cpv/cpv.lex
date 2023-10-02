%%
%unicode
%type String
%eofval{
  return "EOF";
%eofval}

vowel = [aeiouAEIOU]
consonant = [bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]

%%
// Palabras que tienen dos vocales seguidas y terminan en vocal
[:letter:]*{vowel}{2}([:letter:]+{vowel})?[\s:;,.]
{
  return "a";
}
// Palabras que no tienen dos vocales seguidas y terminan en vocal
{consonant}*{vowel}({consonant}+{vowel})*[\s:;,.]
{
  return "b";
}
// Palabras que tienen dos vocales seguidas y terminan en consonante
[:letter:]*{vowel}{2}[:letter:]*{consonant}[\s:;,.]
{
  return "c";
}
// Palabras que no tienen dos vocales seguidas y terminan en consonante
({vowel}?{consonant})*{consonant}[\s:;,.]
{
  return "d";
}

[^]       { /* ignore */ }