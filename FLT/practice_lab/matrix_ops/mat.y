%{
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

expr : VAR { $$ = mem[$1]; }
     ;
     /*
     : expr '+' expr { $$ = add_matr($1, $3); }
     | expr '-' expr { $$ = sub_matr($1, $3); }
     | expr '*' expr { $$ = mul_matr($1, $3); }
     */

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
