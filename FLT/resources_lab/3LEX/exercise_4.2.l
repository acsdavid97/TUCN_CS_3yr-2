    int k;
%%
[-+]?[0-9]+ {
        k = atoi(yytext);
        if (7 <= k && k <= 12) {
            printf("%d", k + 7);
        }else if (k < -100) {
            printf("%d", k * 10);
        }else{
            printf("%d", k);
        }
}

