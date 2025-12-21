grammar DrinkPreference;

program
    : request EOF
    ;

// Ví dụ: "i want a cold coffee with low sugar and no caffeine"
request
    : (prefix)* drinkPref (AND drinkPref)*
    ;

// "i want" | "give me"
prefix
    : I WANT (A)?
    | GIVE ME (A)?
    ;

// 1 cụm mô tả đồ uống
drinkPref
    : prorule (prorule)* 
    ;

prorule
    : temperature
    | baseType
    | sweetness
    | caffeine
    | size
    ;

temperature
    : HOT  
    | WARM  
    | COLD
    | ICED
    ;

baseType
    : COFFEE          
    | TEA             
    | JUICE            
    | MILK TEA        
    | YOGURT         
    ;

caffeine
    : WITH CAFFEINE    
    | WITHOUT CAFFEINE 
    | NO CAFFEINE    
    ;

sweetness
    : NO SUGAR          
    | LOW SUGAR        
    | MEDIUM SUGAR     
    | HIGH SUGAR        
    | LESS SUGAR
    ;

size
    : SMALL
    | MEDIUM
    | LARGE
    ;

AND     : 'and'   | 'And'   ;
I       : 'i'     | 'I'     ;
WANT    : 'want'  | 'Want'  ;
GIVE    : 'give'  | 'Give'  ;
ME      : 'me'    | 'Me'    ;
A       : 'a'     | 'A'     ;

HOT     : 'hot'   | 'Hot'   ;
WARM    : 'warm'  | 'Warm'  ;
COLD    : 'cold'  | 'Cold'  ;
ICED    : 'iced'  | 'Iced'  ;

COFFEE  : 'coffee'  | 'Coffee'  ;
TEA     : 'tea'     | 'Tea'     ;
JUICE   : 'juice'   | 'Juice'   ;
MILK    : 'milk'    | 'Milk'    ;
YOGURT  : 'yogurt'  | 'Yogurt'  ;

SUGAR   : 'sugar'   | 'Sugar'   ;
NO      : 'no'      | 'No'      ;
LOW     : 'low'     | 'Low'     ;
LESS    : 'less' | 'Less'       ;
MEDIUM  : 'medium'  | 'Medium'  ;
HIGH    : 'high'    | 'High'    ;

WITH       : 'with'     | 'With'     ;
WITHOUT    : 'without'  | 'Without'  ;
CAFFEINE   : 'caffeine' | 'Caffeine' ;

UNDER   : 'under'  | 'Under' ;
SMALL   : 'small'  | 'Small' ;
LARGE   : 'large'  | 'Large' ;

NUMBER  : DIGIT+ ;

fragment DIGIT : [0-9] ;
WS : [ \t\r\n]+ -> skip ;
