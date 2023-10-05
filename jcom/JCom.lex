%%
%unicode
// %debug
%int
%{
  // Init vars
  int singleLineCommentChars = 0;
  int multiLineCommentChars = 0;
  int multiLineCommentChars2 = 0;
%}
%eof{
  System.out.println("// " + singleLineCommentChars);
  System.out.println("/* " + multiLineCommentChars);
  System.out.println("/** " + multiLineCommentChars2);
%eof}

// CONSTANTS

// STATES
%xstate SINGLE_LINE_COMMENT
%xstate MULTI_LINE_COMMENT
%xstate MULTI_LINE_COMMENT_2

%%
<YYINITIAL> {
  \".*\" {}
  // Single line comment
  "//" {
    yybegin(SINGLE_LINE_COMMENT);
  }
  // Multi line comment
  "/*" {
    yybegin(MULTI_LINE_COMMENT);
  }
  // Multi line comment 2
  "/**" {
    yybegin(MULTI_LINE_COMMENT_2);
  }
  // Any character
  [^] {}
}

<SINGLE_LINE_COMMENT> {
  [^\s\t\n\r] {
    singleLineCommentChars++;
  }
  \n {
    yybegin(YYINITIAL);
  }
  [^] {}
}

<MULTI_LINE_COMMENT> {
  [^\s\t\n\r] {
    multiLineCommentChars++;
  }
  "*/" {
    yybegin(YYINITIAL);
  }
  [^] {}
}

<MULTI_LINE_COMMENT_2> {
  [^\s\t\n\r] {
    multiLineCommentChars2++;
  }
  "*/" {
    yybegin(YYINITIAL);
  }
  [^] {}
}