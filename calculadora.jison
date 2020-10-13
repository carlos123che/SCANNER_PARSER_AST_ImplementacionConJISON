%{
    //importacioens
%}

/*************************************************LEXICO***********************************************/
%lex
%options case-insensitive 
%%

"EXPRESION"     %{ return 'tk_expresion'; %}
[0-9]+\b        %{ return 'tk_entero'; %}
"["             %{ return 'tk_ca' %}
"]"             %{ return 'tk_cc' %}
"+"             %{ return 'tk_mas'; %}
"*"             %{ return 'tk_menos'; %}
"*"             %{ return 'tk_multiplicar'; %}
"/"             %{ return 'tk_division'; %}
"("             %{ return 'tk_pa'; %}
")"             %{ retrun 'tk_pc'; %}
";"             %{ retrun 'tk_punto_coma'; %}



[ \t\r\n\f]     %{ /*se ignoran*/ %}


<<EOF>> %{ return 'EOF'; %}
.

/lex

/*******************************************SINTACTICA************************************************/
/*......ASOCIACION Y PRECEDENCIA....*/
    //al no tener precedencia de operadores de JISON se hace una gramatica recursiva por la derecha

%start INICIO
%%

INICIO: LEXPRESION EOF;

LEXPRESION: EXPRESION LEXPRESION
            | ;
            
EXPRESION: tk_expresion tk_ca OPERACION tk_cc tk_punto_coma;

OPERACION: T tk_mas OPERACION
    | T tk_menos OPERACION
    | T;

T: F tk_multiplicar T
    | F tk_division T
    | F;

F: tk_entero
    | tk_pa OPERACION tk_pc;

