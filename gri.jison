%{
    //importacioens
%}

/*************************************************LEXICO***********************************************/
%lex
%options case-insensitive 
%%

"EXPRESION"     %{ return 'tk_expresion'; %}
[0-9]+\b        %{ return 'tk_entero'; %}
"["             %{ return 'tk_ca'; %}
"]"             %{ return 'tk_cc'; %}
"+"             %{ return 'tk_mas'; %}
"*"             %{ return 'tk_menos'; %}
"*"             %{ return 'tk_multiplicar'; %}
"/"             %{ return 'tk_division'; %}
"("             %{ return 'tk_pa'; %}
")"             %{ return 'tk_pc'; %}
";"             %{ return 'tk_punto_coma'; %}



[ \t\r\n\f]     %{ /*se ignoran*/ %}


<<EOF>> %{ return 'EOF'; %}
.    { console.log('Error Lexico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }

/lex

/*******************************************SINTACTICA************************************************/
/*......ASOCIACION Y PRECEDENCIA....*/
%left tk_mas tk_menos
%left tk_multiplicar tk_division
%left tk_pa tk_pc
//los operadores unarios tienen más precedencia aun que los de agrupacion

%start INICIO
%%

INICIO: E EOF {};

E: E tk_mas E
    | E tk_menos E
    | E tk_multiplicar E
    | E tk_division E
    | tk_pa E tk_pc
    | E;
