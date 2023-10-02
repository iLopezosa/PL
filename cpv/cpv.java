import java.io.PrintStream;
import java.io.Reader;

public class cpv {
  public static PrintStream out;
  public static void main(String[] args) {
    Reader in;
    String word = "";
    int a = 0;
    int b = 0;
    int c = 0;
    int d = 0;
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
      word = lex.yylex();
      while (word != null && !word.equalsIgnoreCase("EOF")) {
        if (word.equalsIgnoreCase("a")) {
          a++;
        } else if (word.equalsIgnoreCase("b")) {
          b++;
        } else if (word.equalsIgnoreCase("c")) {
          c++;
        } else if (word.equalsIgnoreCase("d")) {
          d++;
        }
        word = lex.yylex();
      }
      out.println("A " + a);
      out.println("B " + b);
      out.println("C " + c);
      out.println("D " + d);
    } catch (Exception e) {
      System.err.println("Error" + e.getMessage());
      System.err.println(e.getStackTrace());
    }
  }
}
