#!/bin/sh

rm *.class Yylex.java;
jflex $1.lex;
javac *.java;
java $1 $2;
zip $1.zip *.lex *.java;