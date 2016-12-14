/* JFlex example: part of Java language lexer specification */
package MIPS;
import java_cup.runtime.*;
import java.io.*;
 
/** 
 * This class is a simple example lexer. 
 */ 

%%
%class LexicalAnalyzerMIPS
                                                                                /*%class Lexer*/
%unicode 
                                                                                /*%standalone*/
%cup
%line 
%column

%{ 
  StringBuffer string = new StringBuffer(); 
 
  private Symbol symbol(int type) { 
    return new Symbol(type, yyline, yycolumn); 
  }
 
  private Symbol symbol(int type, Object value) { 
    return new Symbol(type, yyline, yycolumn, value);
  } 
%}
 
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
 
/* comments */
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}
CommentContent       = ( [^*] | \*+ [^/*] )*
DocumentationComment = "/**" {CommentContent} "*"+ "/"
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment_adicional    = {datos}* "/*" [^*] ~"*/" {datos}*| {datos}* "/*" "*"+ "/" {datos}* | {datos}*
Comment_multiple     = "/*" {TraditionalComment_adicional}+ "*/"

/*variables*/
letter          = [A-Za-z]
number          = [0-9]
other_id_char   = [_]
valido          = ({letter}|{other_id_char}){1,8}
datos           = {letter}|{number}|" " | {other_id_char}

numeros         = 0 | [1-9][0-9]*

%%

/*reglas*/
<YYINITIAL> {

        {Comment_multiple}  {/*ignore*/}                                        /*{System.out.println("He leido un comentario anidado");}*/ 
        {Comment}   {/*ignore*/}                                                /*{System.out.println("He leido un comentario");}*/
        "mostrar"   {return symbol(sym.MOSTRAR);}                                /*{System.out.println("He leido Mostrar");}*/
        "leer"      {return symbol(sym.LEER);}                                   /*{System.out.println("He leido leer");}*/
        ";"         {return symbol(sym.PUNTO_COMA);}                             /*{System.out.println("He leido final de linea");}*/
        "<-"        {return symbol(sym.ASIGNACION);}                             /*{System.out.println("He leido simbolo asignacion");}*/
        "*"         {return symbol(sym.MULTIPLICACION);}                         /*{System.out.println("He leido Multiplicacion");}*/
        "/"         {return symbol(sym.DIVISION);}                               /*{System.out.println("He leido Divivsion");}*/
        "+"         {return symbol(sym.SUMA);}                                   /*{System.out.println("He leido Suma");}*/
        "-"         {return symbol(sym.RESTA);}                                  /*{System.out.println("He leido Resta");}*/
        {valido}    {return symbol(sym.VARIABLE_VALIDA, yytext());}              /*{System.out.println("Elemento valido " + yytext());}*/
        " "         {/*ignore*/}                         
        {LineTerminator}    {/*ignore*/}                      
        "("         {return symbol(sym.PAR_ABIERTO);}
        ")"         {return symbol(sym.PAR_CERRADO);}
        {numeros}    {return symbol(sym.INTEGER_LITERAL, Integer.parseInt(yytext()));}

        /* error fallback */ 
        [^]          { throw new Error("Illegal character <"+ yytext()+">"); }

}