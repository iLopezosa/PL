// IMPORTS
import java.util.HashSet;
%%
%unicode
%debug
%{
  // Init vars
  HashSet<String> articles = new HashSet<>();
  String currentArticle = "";
  float currentDiscount = 0;
  int currentUnits = 0;
  float currentPrice = 0;
%}
%eof{
  System.out.println("@@@ articles = " + articles);
  Ticket.addItemsDistintos(articles.size());
%eof}

// CONSTANTS
REAL_NUMBER = [0-9]+(\.[0-9]+)?
// STATES
%xstate LINE

%%
<YYINITIAL> {
  // New line in receipt
  ^- {
    yybegin(LINE);
  }
  // Any character
  [^] {}
}

<LINE> {
  // Article name (mandatory)
  ([a-zA-Z]\s?)+ {
    currentArticle = yytext().trim();
    articles.add(currentArticle);
    currentUnits = 1;
  }
  // Discount
  {REAL_NUMBER}% {
    String discount = yytext().replace("%", "");
    currentDiscount = Float.parseFloat(discount) / 100;
  }
  // Units
  [1-9][0-9]*uds {
    String trimmedUnits = yytext().replace("uds", "");
    currentUnits = Integer.parseInt(trimmedUnits);
  }
  // Price (mandatory)
  E?{REAL_NUMBER}E?$ {
    String price = yytext().replace("E", "");
    currentPrice = Float.parseFloat(price);
  }
  // End of line
  [\n\r] {
    float finalPrice = currentPrice * (1 - currentDiscount);
    System.out.println("@@@ Adding " + currentUnits + " units of " + currentArticle + " at " + currentPrice + " with " + currentDiscount + " discount = " + finalPrice);
    Ticket.addItems(currentUnits);
    Ticket.addCompra(finalPrice * currentUnits);
    currentArticle = "";
    currentDiscount = 0;
    currentUnits = 0;
    currentPrice = 0;
    yybegin(YYINITIAL);
  }
  [^] {}
}