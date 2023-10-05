import java.io.PrintStream;
import java.io.Reader;

public class wc {
  public static PrintStream out;
  public static void main(String[] args) {
    Reader in;
    try {
      if (args.length > 0) {
        in = new java.io.FileReader(args[0]);
      } else {
        in = new java.io.InputStreamReader(System.in);
      }
      if (args.length > 1) {
        out = new java.io.PrintStream(args[1]);
      } else {
        out = System.out;
      }
      Yylex lex = new Yylex(in);
      out.println(lex.yylex() + " " + args[0]);
    } catch (Exception e) {
      System.err.println("Error" + e.getMessage());
      System.err.println(e.getStackTrace());
    }
  }
}
