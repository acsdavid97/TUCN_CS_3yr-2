%{
#include "y.tab.h"
%}

%%
take {
    return TAKE;
}

drop {
    return DROP;
}

[0-9]+ {
    yylval.ival = atoi(yytext);
    return NUMB;
}

\+\+ {
    return CAT;
}

[(),\[\]\n] {
    return *yytext;
}

[ \t] ;

