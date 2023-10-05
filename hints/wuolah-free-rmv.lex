%%
%unicode
%standalone
%int
%x ASIGNACION
%x ECHO
%x COMILLAS
%x ESTADOASIGNACION

%{
    StringBuffer string = new StringBuffer();
    String variable = new String();
    String valor = new String();
    String ultimoApartado = new String();
%}

Variable = [a-zA-Z_][a-zA-Z_0-9]*
Declaracion = [a-zA-Z0-9][a-zA-Z_0-9]*

%%


// ACLARACIONES: solo con el .lex tiran todas las pruebas bien, no he tocado ninguna otra clase
// A veces utilizo un StringBuffer para ir concatenando las cadenas: el buffer se llama string:
                    // con string.append(yytext()), lo unico que hago es concatenar lo que he leido por pantalla con lo que ya tenia


<YYINITIAL> {

    {Variable}\= {                                      // Pillamos el nombre de la variable y un =: variable=
        variable=yytext();                              // con yytext() cogemos lo que la expresion regular haya pillado
        variable = variable.substring(0,variable.length()-1); // Guardamos lo que pillamos y le quitamos el =
        yybegin(ASIGNACION);                                  // Nos vamos al estado ASIGNACION (hay que declararlo primero arriba)
    }

    "echo " {
        System.out.printf("echo ");
        yybegin(ECHO);
    }

    \n|; {
        TablaSimbolos.put(variable, valor);             // Cada vez que hay un salto de linea o un ;
        string = new StringBuffer();                    // guardamos la variable y su valor en la Tabla de Simbolos
    }

    [^] { } // Salida estandar: por aqui pasa todo lo que no pilla lo de arriba
}


<ASIGNACION> {

    {Declaracion} {                 // Lo hemos definido arriba: al contrario que una variable, puede empezar por un número
        valor=yytext();             // Guardamos el valor y volvemos a YYINITIAL
        yybegin(YYINITIAL);
    }

    {Variable}[\\][\;] {            // Para la prueba 6: si tenemos una \ y un ; seguidos, guardamos el ; en el valor
        valor=yytext();
        yybegin(YYINITIAL);
    }

    \${Variable} {
        string.append(TablaSimbolos.get(yytext()));  // Si leemos $variable, pillamos de la tabla de simbolos su valor
    }

    [\=] {
        string.append(yytext());
        valor = string.toString();
        string = new StringBuffer();
        yybegin(ESTADOASIGNACION);
    }

    ["\""] {
        yybegin(COMILLAS);          // Tenemos que procesar el mensaje entero si están dentro de unas " "
    }

    [^] { } // Salida estandar: por aqui pasa todo lo que no pilla lo de arriba
}

<ECHO> {
    \${Variable} {
        System.out.printf("%s", TablaSimbolos.get(yytext())); // Si encontramos una variable en el echo, obtenemos su valor de la tabla de simbolos
    }

    [^] {
        System.out.printf("%s", yytext()); // como es un echo, todo lo que 
    }                                      // no sea una variable lo imprimimos directamente
}

<COMILLAS> {
    \${Variable} {
        String auxiliar = yytext();                 // Si dentro de unas comillas leemos una variable, tenemos dos opciones:
        if(TablaSimbolos.get(auxiliar)!="") {       // Si la variable está definida en la tabla de simbolos, obtenemos su valor
            auxiliar=TablaSimbolos.get(yytext());
            string.append(auxiliar);
        } else {                                    // Si no se encuentra en la tabla de simbolos:
            String prueba = auxiliar.substring(1,yytext().length());     // Vemos si el valor tiene el mismo nombre que la variable:
            if(variable.equals(prueba)) {                                       // si es asi, no lo imprimimos. Esto es para la prueba 9
                // lo desecho
                //string.append(string.toString());
            } else {                                                     // Si es distinto, guardamos el nombre de la variable en el buffer (linea de abajo)
                string.append(yytext());
            }
        }
    }

    [^\$"\""\\]+ {
        string.append(yytext());   // Resto de los casos: solo leemos
    }

    [\\]["\""][\\].+[\\]["\""] {
        string.append(yytext());   // Resto de los casos: solo leemos
    }

    ["\""] {
        valor = string.toString();    // Si leemos las comillas de cierre, nos vamos al YYINITIAL para guardar la variable y su valor
        yybegin(YYINITIAL);
    }

    [^] { }
}


<ESTADOASIGNACION> {          // Esto es para la prueba 7: tenemos que meter en una variable un valor que contenga un =
    [\$]{Variable} {            // Si leemos una variable, sacamos el valor de su tabla de simbolos sii existe.
        if(TablaSimbolos.get(yytext())!=""){
            string.append(TablaSimbolos.get(yytext()));
        } else {
            string.append(yytext());
        }
    }

    [^\$\n]+ {
        string.append(yytext());    // Resto de los casos: solo leemos
    }

    \n {                            // El salto de linea nos indica que hemos terminado de leer el valor
        valor=valor+string.toString();      
        TablaSimbolos.put(variable, valor);
        yybegin(YYINITIAL);
    }

    [^] { }

}