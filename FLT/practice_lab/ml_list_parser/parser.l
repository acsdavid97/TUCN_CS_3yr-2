%{
#include "y.tab.h"

int yylval;
%}

%%
[0-9]+ { 
         yylval = atoi(yytext);
         return NUMB;
       }

[()\[\],\n;] { 
         return *yytext;
        }
tail {
         return TAIL;
       }
head {
         return HEAD;
       }
:: {
        return CONS;
      }
"@" { 
        return CONCAT;
     }

[ \t] ;

