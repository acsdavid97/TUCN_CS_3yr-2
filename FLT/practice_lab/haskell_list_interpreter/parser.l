%{
#include "y.tab.h"

int yylval;
%}

%%
[0-9]+ { 
         yylval = atoi(yytext);
         return NUMB;
       }

[(),\n;] { 
         return *yytext;
        }
insert {
         return INSERT;
       }
count {
        return COUNT;
      }
Node { 
        return NODE;
     }

Lf {
        return LF;
   }
[ \t] ;

