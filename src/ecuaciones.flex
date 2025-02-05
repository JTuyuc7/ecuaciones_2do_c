import java.util.ArrayList;
import java.util.List;

%%
%public
%class EcuacionesLexer
%unicode
%function yylex
%type String

%{
/**
 * Lista de tokens válidos reconocidos.
 */
private List<String> validTokens = new ArrayList<>();

public List<String> getTokensValidos() {
    return validTokens;
}

// Variable que nos permitirá recolectar tokens línea a línea.
private List<String> lineaTokens = new ArrayList<>();

// Guardaremos todas las “líneas tokenizadas” en una sola lista de listas.
private List<List<String>> listaDeListas = new ArrayList<>();

// Getter para obtener la lista de listas final
public List<List<String>> getListaDeListas() {
    return listaDeListas;
}

/**
 * Llamado cada vez que terminamos una línea.
 * Guardamos la lista de tokens de esa línea y la reseteamos.
 */
private void finLinea() {
    if (!lineaTokens.isEmpty()) {
        // Guardamos la línea actual
        if (esEcuacionDeSegundoGrado(lineaTokens)) {
                    listaDeListas.add(new ArrayList<>(lineaTokens));
                }
        lineaTokens.clear();
    }
}

private boolean esEcuacionDeSegundoGrado(List<String> tokens) {
    // Aquí la idea es “parsear” por tu cuenta.
    // Por ejemplo, buscas si existe al menos un 'X' seguido de '^' seguido de '2'.
    // También podrías exigir que tenga un ‘=’ y un ‘0’ al final o no, etc.
    // El siguiente ejemplo es MUY básico:

    boolean tieneXPow2 = false;
    boolean tieneIgual0 = false;

    for (int i = 0; i < tokens.size(); i++) {
        // Detectar algo como "X", "^", "2" en secuencia:
        if (i + 2 < tokens.size()) {
            if (tokens.get(i).endsWith("X")     // p. ej. "X", "5X", "10X"
                && "^".equals(tokens.get(i+1))  // el token del caret
                && "2".equals(tokens.get(i+2))  // el token que es "2"
            ) {
                tieneXPow2 = true;
            }
        }
        // Detectar = 0 (opcional, según tu regla):
        if ("=".equals(tokens.get(i))
            && i+1 < tokens.size()
            && "0".equals(tokens.get(i+1))) {
            tieneIgual0 = true;
        }
    }

    // Criterio súper elemental: requiere un término X^2 y (opcional) “= 0”.
    // Podrías mejorarlo exigiendo también un término lineal, etc.
    // Ajusta a tu gusto.
    return (tieneXPow2 /* && tieneIgual0 */);
}


%}

/*
  Macros para reconocer tipos de componentes:
  - DIGITO: dígitos 0-9
  - NUMDEC: número decimal opcional (entero o con punto decimal),
            OJO: tal como está, no reconoce signo '-' o '+'. (ver más abajo)
  - VARIABLE: algo como 3X, X2, 10X5, X, etc.
             (si SOLO quieres 'X' con dígitos delante/detrás, sin otras letras).
  - WHITESPACE: espacios en blanco, tabuladores, saltos de línea.
*/

DIGITO        = [0-9]
NUMDEC        = {DIGITO}+(\.{DIGITO}+)?  /* entero o decimal */
VARIABLE      = [0-9]*[Xx]         /* p.ej. X, 3X, X1, 12X3, etc. */
WHITESPACE    = [ \t]+

%%

/* Ignorar espacios en blanco (pero no newlines) */
{WHITESPACE} {
    // se ignoran, no se retornan
}

/*
   Cuando encontremos un salto de línea, es un indicador de que
   terminó una ecuación (o una línea de texto).
   - Guardamos la lista de tokens de esa línea en listaDeListas.
   - Reseteamos la lista de tokens para la siguiente línea.
*/
\r?\n {
    finLinea();
}

/* Operador potencia */
"^" {
    lineaTokens.add("^");
    validTokens.add("^");
    return "^";
}

/* Operador de igualdad */
"=" {
    lineaTokens.add("=");
    validTokens.add("=");
    return "=";
}

/* Operador + */
"+" {
    lineaTokens.add("+");
    validTokens.add("+");
    return "+";
}

/* Operador - */
"-" {
    lineaTokens.add("-");
    validTokens.add("-");
    return "-";
}

/* Reconocer números (coeficientes) */
{NUMDEC} {
    String texto = yytext();
    lineaTokens.add(texto);
    validTokens.add(texto);
    return texto;
}

/* Reconocer variables del tipo definido en la macro VARIABLE */
{VARIABLE} {
    String texto = yytext();
    lineaTokens.add(texto);
    validTokens.add(texto);
    return texto;
}

/* Cualquier carácter “raro” lo podemos ignorar o marcar error; aquí lo ignoramos */
. {
    // Ignorar
}

/* EOF: fin de archivo */
<<EOF>> {
    // Por si el archivo no termina en salto de línea,
    // guardamos la última línea tokenizada si hay tokens acumulados
    finLinea();
    return null;
}
