%option noyywrap

%{
/* This is my first C macro! */
#define SHOWSYM(SYMBOL)		symname = strdup(SYMBOL); showsym(&symname);

void showsym(char *sym[]) {
     printf("Symbol: %s\n", *sym);
}

char *symname;
char *tokname;
%}

%x EXITDIR

%%
[ \t]+		{ /* Ignore */ }	
\n		{ /* Ignore */ }
":"		{ SHOWSYM("COLON") }
";"		{ SHOWSYM("SEMICOLON") }
"="		{ SHOWSYM("EQ") }
^ROOMDEF	{ SHOWSYM(yytext) }
^ENDROOMDEF	{ SHOWSYM(yytext) }
^OBJDEF 	{ SHOWSYM(yytext) }
^ENDOBJDEF	{ SHOWSYM(yytext) }
^IDENTDEF	{ SHOWSYM(yytext) }
^EXITDEF	{ SHOWSYM(yytext) BEGIN(EXITDIR);}
<EXITDIR>[ \t+]	  	{ /* Ignore */ }
<EXITDIR>"="		{ SHOWSYM("EQ") }
<EXITDIR>_NORTH_	{ tokname = strdup(yytext); printf("Token: DIRECTION; Value: %s\n", tokname); BEGIN(INITIAL); }
<EXITDIR>_EAST_		{ tokname = strdup(yytext); printf("Token: DIRECTION; Value: %s\n", tokname); BEGIN(INITIAL); }
<EXITDIR>_SOUTH_	{ tokname = strdup(yytext); printf("Token: DIRECTION; Value: %s\n", tokname); BEGIN(INITIAL); }
<EXITDIR>_WEST_		{ tokname = strdup(yytext); printf("Token: DIRECTION; Value: %s\n", tokname); BEGIN(INITIAL); }



^ALIASDEF	{ SHOWSYM(yytext) }
^LOCDEF		{ SHOWSYM(yytext) }
^USEDEF		{ SHOWSYM(yytext) }
^FLAGDEF	{ SHOWSYM(yytext) }


_([A-Z]+_)+	{ tokname = strdup(yytext); printf("Token: INTERNAL-NAME; Value: %s\n", tokname); }

\"[^"]+\"	{ tokname = strdup(yytext); printf("Token: QUOTED-STRING; Value: %s\n", tokname); }

%%
int main() {
    while (yylex() != 0);
    return 0;
}
