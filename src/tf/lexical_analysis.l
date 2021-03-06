/*
* Author:HanRuobing
*Created on:2018-2-9
*Description:lexical analysis for tensorflow's network construction
*/
%{
#include "stdio.h"
#include "stdlib.h"
#include "syntactic_analysis.tab.h"
#include "util.h"
%}
type int|float
NONE None
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while
PLUS \+
MINIMIZE minimize
MINUS -
MUL \*
DIV \/
INTEGER [1-9]+[0-9]*|0
FLOAT   [0-9]+\.[0-9]*
BOOL True|False
SPACE [ \t\r]*
EOL \n
COLON :
SEMI ;
COMMA ,
WELL #
ASSIGNOP =
RELOP >|<|>=|<=|==|!=
AND &&
OR \|\|
DOT \.
NOT !
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
WITH with
NAMESCOPE tf\.name_scope
ZEROS tf\.zeros
UNSTACK tf\.unstack
MATMUL tf\.matmul
CONSTANT tf\.constant
RESHAPE tf\.reshape
MAX_POOL tf\.nn\.max_pool
DTYPE tf\.float32
PLACEHOLDER tf\.placeholder
RELU tf\.nn\.relu
BIAS_ADD tf\.nn\.bias_add
CONV2D tf\.nn\.conv2d
SOFTMAX tf\.nn\.softmax
TFVARIABLE tf\.Variable
LRN tf\.nn\.lrn
DROPOUT tf\.nn\.dropout
RANDOM_NORMAL tf\.random_normal
TRUNCATED_NORMAL tf\.truncated_normal
ADAMOPTIMIZER tf\.train\.AdamOptimizer
GDOPTIMIZER tf\.train\.GradientDescentOptimizer
SOFTMAX_CROSS_ENTROPY_WITH_LOGITS tf\.nn\.softmax_cross_entropy_with_logits
SPARSE_SOFTMAX_CROSS_ENTROPY tf\.losses\.sparse_softmax_cross_entropy
REDUCE_MEAN tf\.reduce_mean
BASICLSTMCELL tf\.contrib\.rnn\.BasicLSTMCell
STATIC_RNN tf\.nn\.static_rnn
VARIABLE [a-z_A-Z][a-zA-Z_0-9]*
STRING [\'\"][a-zA-Z_0-9]*[\'\"]
AERROR .
COMMENT #[^\n]*\n
MASS [.]*
%%
{ASSIGNOP} {return ASSIGNOP;}
{EOL} {}
{RELU} {return RELU;}
{BIAS_ADD} {return BIAS_ADD;}
{CONV2D} {return CONV2D;}
{TFVARIABLE} {return TFVARIABLE;}
{RANDOM_NORMAL} {printf("get random normal");return RANDOM_NORMAL;}
{TRUNCATED_NORMAL} {return TRUNCATED_NORMAL;}
{WITH} {return WITH;}
{NAMESCOPE} {return NAMESCOPE;}
{FLOAT} {printf("get float:%s\n",yytext);
        yylval.str = malloc(sizeof(char*) * strlen(yytext));
        strcpy(yylval.str,yytext);
        return FLOAT;}
{DTYPE} {printf("get dtype:%s\n",yytext);
        yylval.str = malloc(sizeof(char*) * strlen(yytext));
        strcpy(yylval.str,yytext);
        return DTYPE;}
{INTEGER} {printf("get integer:%s\n",yytext);
        yylval.str = malloc(sizeof(char*) * strlen(yytext));
        strcpy(yylval.str,yytext);
        return INTEGER;}
True|False {printf("get bool:%s\n",yytext);
            yylval.str = malloc(sizeof(char*) * strlen(yytext));
            strcpy(yylval.str,yytext);
            return BOOL;}
{PLUS} {yylval.str = "+";return PLUS;}
{MINUS} {yylval.str = "-";return MINUS;}
{MUL} {yylval.str = "*";return MUL;}
{DIV} {yylval.str = "//";return DIV;}
{DOT} {return DOT;}
{COLON} {return COLON;}
{NONE} {yylval.str = "None";return NONE;}
{PLACEHOLDER} {yylval.str = "placeholder";return PLACEHOLDER;}
{UNSTACK} {yylval.str ="unstack";return UNSTACK;}
{MATMUL} {yylval.str = "matmul";return MATMUL;}
{CONSTANT} {yylval.str = "constant";return CONSTANT;}
{RESHAPE} {yylval.str = "reshape";return RESHAPE;}
{MAX_POOL} {yylval.str = "maxpool";return MAX_POOL;}
{LRN} {yylval.str = "LRN";return LRN;}
{DROPOUT} {yylval.str = "dropout";return DROPOUT;}
{ADAMOPTIMIZER} {yylval.str = "adamoptimizer";return ADAMOPTIMIZER;}
{GDOPTIMIZER} {yylval.str ="gdoptimizer";return GDOPTIMIZER;}
{SOFTMAX_CROSS_ENTROPY_WITH_LOGITS} {yylval.str = "softmax_cross_entropy_with_logits";return SOFTMAX_CROSS_ENTROPY_WITH_LOGITS;}
{REDUCE_MEAN} {yylval.str = "reduce_mean";return REDUCE_MEAN;}
{BASICLSTMCELL} {yylval.str = "basicLSTMcell";return BASICLSTMCELL;}
{STATIC_RNN} {yylval.str = "static_rnn";return STATIC_RNN;}
{SOFTMAX} {yylval.str = "softmax";return SOFTMAX;}
{SPARSE_SOFTMAX_CROSS_ENTROPY} {yylval.str = "sparse_softmax_cross_entropy";return SPARSE_SOFTMAX_CROSS_ENTROPY;}
{ZEROS} {yylval.str = "zeros";return ZEROS;}
{LP} {yylval.str = "(";return LP;}
{RP} {yylval.str = ")";return RP;}
{LB} {yylval.str = "[";return LB;}
{RB} {yylval.str = "]";return RB;}
{MINIMIZE} {return MINIMIZE;}
{COMMA} {yylval.str = ",";return COMMA;}
{WELL} {yylval.str = "#";return WELL;}
{COMMENT} {printf("get comment:%s\n",yytext);
            yylval.str = malloc(sizeof(char*) * strlen(yytext));
            strcpy(yylval.str,yytext);
            return COMMENT;}
{VARIABLE} {printf("get variable:%s\n",yytext);
            yylval.str = malloc(sizeof(char*) * strlen(yytext));
            strcpy(yylval.str,yytext);
            return VARIABLE;}
{STRING} {printf("get string:%s\n",yytext);
            yylval.str = malloc(sizeof(char*) * strlen(yytext));
            strcpy(yylval.str,yytext);
            return STRING;}
{MASS} {printf("mass:%s\n",yytext);yylval.str = malloc(sizeof(char*) * strlen(yytext));
        strcpy(yylval.str,yytext);
        return MASS;}
{SPACE} {}
%%
int yywrap()
{
    return 1;
}
