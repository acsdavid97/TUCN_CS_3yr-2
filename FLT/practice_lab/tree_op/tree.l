%{
#include "y.tab.h"
%}

%%
[0-9]+ { 
         yylval.ival = atoi(yytext);
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

