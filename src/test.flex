/*
 * Ejemplo: scanner para ecuaciones de 2º grado con JFlex
 */

%%
/** Sección de opciones de JFlex **/
%class EcuacionCuadraticaLexer
%unicode
%public
%line
%column

%%

/** Aquí empiezan las reglas léxicas **/

/* Ignoramos espacios en blanco y tabuladores */
[\t\n\r ]+ { /* no devolvemos token, solo ignoramos */ }

/* Un número puede ser entero o real */
([0-9]+(\.[0-9]+)?)  {
  System.out.println("TOKEN_NUM(" + yytext() + ")");
}

/* Variable X (asumiendo que sólo es ‘x’ o ‘X’) */
[xX] {
  System.out.println("TOKEN_VAR(" + yytext() + ")");
}

/* Operador de potencia ^ */
"^" {
  System.out.println("TOKEN_CARET");
}

/* Signos + y - */
"+" {
  System.out.println("TOKEN_MAS");
}
"-" {
  System.out.println("TOKEN_MENOS");
}

/* Signo de igualdad = */
"=" {
  System.out.println("TOKEN_IGUAL");
}

/* Cualquier otro símbolo no reconocido */
. {
  System.out.println("TOKEN_DESCONOCIDO(" + yytext() + ")");
}
