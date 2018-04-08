%{
#include <stdlib.h>
#include <stdio.h>

typedef struct _cons {
    int car;
    struct _cons *cdr;
} cons_t;

cons_t *concat(cons_t* l1, cons_t *l2);
cons_t *cons(int e, cons_t *l);
void print_list(cons_t *list);
cons_t* cdr(cons_t *l);
int car(cons_t *l); 
int sum_list(cons_t *l);
cons_t* concat_all(cons_t *l);

%}
%union {
    int ival;
    struct _cons *list;
}

%token CONS APPEND CAR CDR
%token <ival> NUMB

%type <ival> i_form i_command num_seq
%type <list> l_form l_command enum l_seq

%%
file : file form '\n'
     | file '\n'
     | /* empty */
     ;

form : i_form { printf("%d\n", $1); }
     | l_form { print_list($1); }

i_form : '(' i_command ')'
            { $$ = $2; }
       | NUMB 
       ;
i_command : CAR l_form { $$ = car($2); }
          | '+' num_seq { $$ = $2; }
          ;

l_form : '(' l_command ')' { $$ = $2; }
       | '\'' '(' enum ')' { $$ = $3; }
       ;

l_command : CDR l_form { $$ = cdr($2); }
          | CONS i_form l_form { $$ = cons($2, $3); }
          | APPEND l_form l_seq 
          { $$ = concat($2, $3); }
enum : NUMB enum
     { $$ = cons($1, $2); }
     | NUMB
        { $$ = cons($1, NULL); }
     ;

num_seq : i_form num_seq { $$ = $1 + $2; }
        | i_form {$$ = $1; }
        ;
l_seq   : l_form  l_seq { $$ = concat($1, $2); }
        | l_form {$$ = $1; }
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

int sum_list(cons_t *list) {
    if (list == NULL) {
        return 0;
    }

    return list->car + sum_list(list->cdr);
}
