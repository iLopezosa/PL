package PL.suma;

import java.io.*;

public class Suma {
  public static PrintStream out;
  public static void main(String[] args) {
    Reader in;
    try {
      if (args.length > 0) {
        in = new FileReader(args[0]);
      } else {
        in = new InputStreamReader(System.in);
      }
      if (args.length > 1) {
        out = new PrintStream(args[1]);
      } else {
        out = System.out;
      }
      Yylex lex = new Yylex(in);
      lex.yylex();
    } catch (Exception e) {
      System.err.println("Error" + e.getMessage());
      System.err.println(e.getStackTrace());
    }
  }
}