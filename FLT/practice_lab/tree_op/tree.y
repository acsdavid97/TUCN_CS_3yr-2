
%{
#include <stdio.h>

typedef struct _node{
    int key;
    struct _node *l, *r;
}node;

int count_nodes(node* t);
node* insert_node(int i, node* t);
node* make_node(int i, node* l, node* r);
void print_tree(node* tree);

%}

%union {
    int ival;
    struct _node *tree;
}


%token <ival> NUMB 
%token COUNT LF NODE INSERT

%type <tree> t_expr tree
%type <ival> i_expr


%%
file : file expr ';' '\n'
     | file '\n'
     |
     ;

expr : i_expr {printf("%d\n", $1);}
     | t_expr {print_tree($1);}
     ;

i_expr : NUMB
       | COUNT '(' t_expr ')' { $$ = count_nodes($3); }
       ;

t_expr : INSERT '(' i_expr ',' t_expr ')' { $$ = insert_node($3, $5); }
       | tree
       ;

tree : LF { $$ = NULL; }
     | NODE '(' i_expr ',' tree ',' tree ')' { $$ = make_node($3, $5, $7); }
     ;

%%
int count_nodes(node* t)
{
    if (t == NULL) 
    {
        return 0;
    }

    int left_count = count_nodes(t->l);
    int right_count = count_nodes(t->r);

    return 1 + left_count + right_count;
}

node* insert_node(int i, node* t)
{
    if (t == NULL)
    {
        return make_node(i, NULL, NULL);
    }

    if (i < t->key) 
    {
        t->l = insert_node(i, t->l);
    }
    else
    {
        t->r = insert_node(i, t->r);
    }

    return t;    
}

node* make_node(int i, node* l, node* r)
{
    node* n = (node*) malloc(sizeof(node));
    n->key = i;
    n->l = l;
    n->r = r;
    return n;
}

void print_tree(node* tree)
{
    if (tree == NULL)
    {
       printf("Lf");
       return;
    }

    printf("Node(%d,", tree->key);
    print_tree(tree->l);
    printf(",");
    print_tree(tree->r);
    printf(")");
}

