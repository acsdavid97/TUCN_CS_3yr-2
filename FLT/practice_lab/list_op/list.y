%{
#include <stdlib.h>
#include <stdio.h>

typedef struct _cons {
    int car;
    struct _cons *cdr;
}cons_t;

cons_t *concat(cons_t* l1, cons_t *l2);
cons_t *cons(int e, cons_t *l);
void print_list(cons_t *list);
cons_t* cdr(cons_t *l);
int car(cons_t *l); 
cons_t* take(cons_t* l, int n);
cons_t* drop(cons_t* l, int n);

%}

%token DROP TAKE CAT

%left CAT

%union{
    int ival;
    struct _cons* list;
}

%token<ival> NUMB
%type <list> l_expr enum

%%
file : file l_expr '\n' { print_list($2); }
     | file '\n'
     |
     ;

l_expr : l_expr CAT l_expr { $$ = concat($1, $3); }
     | '(' l_expr ')' {$$ = $2; }
     | TAKE l_expr NUMB { $$ = take($2, $3); }
     | DROP l_expr NUMB { $$ = drop($2, $3); }
     | '[' enum ']' { $$ = $2; }
     ;

enum : NUMB ',' enum { $$ = cons($1, $3); }
     | NUMB { $$ = cons($1, NULL); }
     ;

%%
cons_t *cons(int e, cons_t *l)
{
    cons_t *rez = (cons_t*)malloc(sizeof(cons_t));
    rez->car = e;
    rez->cdr = l;
    return rez;
}

int car(cons_t *l)
{
    return l->car;
}

cons_t* cdr(cons_t *l)
{
    return (l->cdr);
}

cons_t *concat(cons_t* l1, cons_t *l2)
{
    if (l1->cdr == NULL){
        return cons(l1->car, l2);
    }else{
        return cons(l1->car, concat(l1->cdr, l2));
    }
}

void print_l(cons_t* l){
    if (l == NULL) {
        return;
    }
    printf("%d ", l->car);
    print_l(l->cdr);
}

void print_list(cons_t *list){
    printf("(");
    print_l(list);
    printf(")\n");
}

cons_t* take(cons_t* l, int n){
    cons_t* current = l;
    for(int i = 0; i < n; i++){
        current = current->cdr;
    }
    current->cdr = NULL;
    return l;
}

cons_t* drop(cons_t* l, int n){
    cons_t* current = l;
    for(int i = 0; i < n; i++){
        current = current->cdr;
    }
    return current;
}

