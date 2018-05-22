%{

#include<stdio.h>

#define MAX 255


typedef struct _line {
    int elems[MAX];
    int no_columns_used;
}line;

typedef struct _matr{
    line *rows[MAX];
    int no_rows_used;
}matr;


matr *mem[26];

line* create_row(int numb);
line* add_elem(line* m, int numb);
matr* add_row(matr* m, line *l);
matr* create_matr(line *l);
void print_matr(matr* m);
matr* add_matr(matr* m1, matr* m2);
matr* sub_matr(matr* m1, matr* m2);
matr* mul_matr(matr* m1, matr* m2);

%}

%union {
    struct _matr *mat;
    struct _line *line;
    int ival;
}

%token <ival> NUMB VAR

%type <mat> matrix expr
%type <line> row

%left '+' '-'
%left '*'

%%
file : file stmt '\n'
     | file '\n'
     | /* empty, empsilon */
     ;

stmt : VAR '=' matrix ';' { mem[$1] = $3; }
     | expr ';' { print_matr($1); }

expr : expr '+' expr { $$ = add_matr($1, $3); }
     | expr '-' expr { $$ = sub_matr($1, $3); }
     | expr '*' expr { $$ = mul_matr($1, $3); }
     | VAR { $$ = mem[$1]; }
     ;

matrix : matrix '\n' row { $$ = add_row($1, $3); }
       | row { $$ = create_matr($1); }

row : row NUMB { $$ = add_elem($1, $2); } 
    | NUMB { $$ = create_row($1); }
    ;


%%
line* create_row(int numb)
{
    line *l = (line*)malloc(sizeof(line));
    l->elems[0] = numb;
    l->no_columns_used = 1;
    return l;
}

line* add_elem(line* r, int numb)
{
    r->elems[r->no_columns_used] = numb;
    r->no_columns_used++;
    return r;
}

matr* create_matr(line *l)
{
    matr* m = (matr*) malloc(sizeof(matr));
    m->rows[0] = l;
    m->no_rows_used = 1;
    return m;
}

matr* add_row(matr* m, line *l)
{
    m->rows[m->no_rows_used] = l;
    m->no_rows_used++;
    return m;
}

void print_matr(matr* m)
{
    for(int i = 0; i < m->no_rows_used; i++)
    {
        line* l = m->rows[i];
        for(int j = 0; j < l->no_columns_used; j++)
        {
            printf("%d ", l->elems[j]);
        }
        printf("\n");
    }
}

line* add_op_row(line* l1, line* l2)
{
    if (l1->no_columns_used != l2->no_columns_used) 
    {
        printf("different column size\n");
        return NULL;
    }

    line* added = create_row(l1->elems[0] + l2->elems[0]);
    for(int i = 1; i < l1->no_columns_used; i++)
    {
        add_elem(added, l1->elems[i] + l2->elems[i]);
    }

    return added;
}

matr* add_matr(matr* m1, matr* m2)
{
    if (m1->no_rows_used != m2->no_rows_used)
    {
        printf("different row size\n");
        return NULL;
    }
    

    line* first_line = add_op_row(m1->rows[0], m2->rows[0]);
    matr* added_matr = create_matr(first_line);
    for(int i = 1; i < m1->no_rows_used; i++)
    {
        line* added_line = add_op_row(m1->rows[i], m2->rows[i]);
        add_row(added_matr, added_line);
    }
    return added_matr;
}

line* sub_op_row(line* l1, line* l2)
{
    if (l1->no_columns_used != l2->no_columns_used) 
    {
        printf("different column size\n");
        return NULL;
    }

    line* subbed = create_row(l1->elems[0] - l2->elems[0]);
    for(int i = 1; i < l1->no_columns_used; i++)
    {
        add_elem(subbed, l1->elems[i] - l2->elems[i]);
    }

    return subbed;
}

matr* sub_matr(matr* m1, matr* m2)
{
    if (m1->no_rows_used != m2->no_rows_used)
    {
        printf("different row size\n");
    }
    
    line* first_line = sub_op_row(m1->rows[0], m2->rows[0]);
    matr* subbed_matr = create_matr(first_line);
    for(int i = 1; i < m1->no_rows_used; i++)
    {
        line* subbed_line = add_op_row(m1->rows[i], m2->rows[i]);
        add_row(subbed_matr, subbed_line);
    }
    return subbed_matr;
}

int mul_calc_elem(matr* m1, matr* m2, int line_index, int row_index)
{
    int sum = 0;       
    for(int j = 0; j < m2->no_rows_used; j++)
    {
        sum += m1->rows[line_index]->elems[j] * m2->rows[j]->elems[row_index];
    }
    return sum;
}

line* mul_line(matr* m1, matr* m2, int line_index)
{
    int first_elem = mul_calc_elem(m1, m2, line_index, 0);
    line* l = create_row(first_elem);
    for(int i = 1; i < m2->rows[line_index]->no_columns_used; i++)
    {
        int elem = mul_calc_elem(m1, m2, line_index, i);
        add_elem(l, elem);
    }

    return l;
}

matr* mul_matr(matr* m1, matr* m2)
{
    line* first_line = mul_line(m1, m2, 0);
    matr* m = create_matr(first_line);
    for(int i = 1; i < m1->no_rows_used; i++)
    {
        line* l = mul_line(m1, m2, i);
        add_row(m, l);
    }

    return m;
}

