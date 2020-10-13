%{
    //importacioens
%}

/*************************************************LEXICO***********************************************/
%lex
%options case-sensitive 
%%

\s+     /*omitir espacios en blanco*/

// [conjuntos] "patrones o palabras resevadas"
[0-9]+"."[0-9]+\b   %{return 'tk_decimal'; %}
[0-9]+\b            %{return 'tk_entero'; %}

"double"    %{return 'tk_double'; %}
//capturar palabras reservada antes que ID 

[a-zA-Z]([a-zA-Z0-9_])*     %{return 'tk_identificador'; %}
"//"[\n]*                   %{ yytext.substr(1,yyleng-2); return 'tk_comentario'; %}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]      %{ yytext.substr(1,yyleng-2); return 'tk_comentario'; %}

[ \t\r\n\f]     %{ /*se ignoran*/ %}

[\"][^\\\"]*([\\][\\\"ntr][^\\\"]*)*[\"]     %{ yytext.substr(1,yyleng-2); return 'tk_cadena'; %}

<<EOF>> %{ return 'EOF'; %}
//EOF es el fin del archivo siempre deben estar incluido en mi archivo si no da error JISON

.   {console.log("ERROR LEXICO CON: " + yytext); }

/lex

/*******************************************SINTACTICA************************************************/
/*......ASOCIACION Y PRECEDENCIA....*/


%start S
%%
