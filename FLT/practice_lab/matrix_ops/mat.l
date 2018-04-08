%{
    #include "y.tab.h"
%}

%%
[A-Z] {yylval.ival = *yytext - 'A';
        return VAR;}
[0-9] { yylval.ival = atoi(yytext); }

[ \t] ;

