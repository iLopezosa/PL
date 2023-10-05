import java.io.PrintStream;
import java.io.Reader;

public class JCom {
  public static PrintStream out;
  public static void main(String[] args) {
    Reader in;
    try {
      if (args.length > 0) {
        in = new java.io.FileReader(args[0]);
        Yylex lex = new Yylex(in);
        lex.yylex();
      } 
    } catch (Exception e) {
      System.err.println("Error" + e.getMessage());
      System.err.println(e.getStackTrace());
    }
  }
}


