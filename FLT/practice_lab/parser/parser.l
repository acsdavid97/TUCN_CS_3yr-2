%{
#include "yy.tab.h"
int yylval;
%}


%%
[0-9]+ {
    yylval = atoi(yytext);
    return NUMB;
}

[\n()+] {
    return *yytext;
}

[ \t] {
    ;
}

