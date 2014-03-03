%lex
%%


\n+                                             return 'NL';
\s+                                             /* ignore whitespace */
\#[^\n]*                                        /* skip comments */
':'                                             return ':'
'{'                                             return '{'
'}'                                             return '}'
'['                                             return '['
']'                                             return ']'
','                                             return ','
[1-9]\d*                                        return 'NUMBER'
\"(?:[^\"\\]|\\.)*\"                            return 'STRING'
\'(?:[^\'\\]|\\.)*\'                            return 'STRING'
[a-zA-Z\$_]*[^:^{^}][a-zA-Z\$_]*                return 'STRING'
<<EOF>>                                         return 'EOF'

/lex

%{
    function quote (input) {
        input = input.replace(/['"]/g, '');
        return "\"" + input + "\"";
    }
%}

%%

cson    
    : object EOF    
        { return $object1; }
    ;

object
    : '{' lines '}' NL
        { $$ = '{' + $lines1 + '}'; }
    | '{' lines '}'
        { $$ = '{' + $lines1 + '}'; }
    | '{' NL lines '}' NL
        { $$ = '{' + $lines1 + '}'; }
    | '{' NL lines '}' 
        { $$ = '{' + $lines1 + '}'; }
    ;

lines
    : lines line
        { $$ = $lines1 + ',' + $line1; }
    | line      
        { $$ = $line1; }
    ;

line
    : pair NL   
        { $$ = $pair1; }
    | pair
    ;

pair
    : STRING ':' STRING
        { $$ = quote($STRING1) + ':' + quote($STRING2); }
    
    | STRING ':' NUMBER
        { $$ = quote($STRING1) + ':' + $NUMBER1; }
    
    | STRING ':' array
        { $$ = quote($STRING1) + ':' + $array1; }
    
    | STRING ':' '{' lines '}'
        { $$ = quote($STRING1) + ':' + '{' + $lines1 + '}'; }
    ;

array
    : '[' list ']'
        { $$ = '[' + $list1 + ']'; }
    ;

list
    : list ',' list_item
        { $$ = $list1 + ',' + $list_item1; }
    | list_item
    ;

list_item
    : STRING
        { $$ = quote($STRING1); }
    | NUMBER
    | array
    | '{' lines '}'
        { $$ = '{' + $lines1 + '}'; }
    ;
