grammar DrinkPreference;

// ========== Parser Rules ==========

program
    : request EOF
    ;

// Ví dụ: "i want cold coffee with low sugar and no caffeine"
request
    : (prefix)* drinkPref (AND drinkPref)*
    ;

// "i want" | "give me"
prefix
    : I WANT
    | GIVE ME
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

// ---------- các thuộc tính ----------

temperature
    : HOT  
    | WARM  
    | COLD
    | ICED
    ;

baseType
    : COFFEE            //"coffee"
    | TEA               //"tea"
    | JUICE             //"juice"
    | MILK TEA          // "milk tea"
    | YOGURT           // "yogurt"
    ;

sweetness
    : NO SUGAR          // "no sugar"
    | LOW SUGAR         // "low sugar"
    | MEDIUM SUGAR      // "medium sugar"
    | HIGH SUGAR        // "high sugar"
    ;

caffeine
    : WITH CAFFEINE     // "with caffeine"
    | WITHOUT CAFFEINE  // "without caffeine"
    | NO CAFFEINE       // "no caffeine"
    ;



size
    : SMALL
    | MEDIUM
    | LARGE
    ;

// ========== Lexer Rules ==========

// từ nối
AND     : 'and'   | 'And'   ;
I       : 'i'     | 'I'     ;
WANT    : 'want'  | 'Want'  ;
GIVE    : 'give'  | 'Give'  ;
ME      : 'me'    | 'Me'    ;

// temperature
HOT     : 'hot'   | 'Hot'   ;
WARM    : 'warm'  | 'Warm'  ;
COLD    : 'cold'  | 'Cold'  ;
ICED    : 'iced'  | 'Iced'  ;

// base drink
COFFEE  : 'coffee'  | 'Coffee'  ;
TEA     : 'tea'     | 'Tea'     ;
JUICE   : 'juice'   | 'Juice'   ;
MILK    : 'milk'    | 'Milk'    ;
YOGURT  : 'yogurt'  | 'Yogurt'  ;

// sweetness
SUGAR   : 'sugar'   | 'Sugar'   ;
NO      : 'no'      | 'No'      ;
LOW     : 'low'     | 'Low'     ;
MEDIUM  : 'medium'  | 'Medium'  ;
HIGH    : 'high'    | 'High'    ;

// caffeine
WITH       : 'with'     | 'With'     ;
WITHOUT    : 'without'  | 'Without'  ;
CAFFEINE   : 'caffeine' | 'Caffeine' ;

// price & size
UNDER   : 'under'  | 'Under' ;
SMALL   : 'small'  | 'Small' ;
LARGE   : 'large'  | 'Large' ;

// số
NUMBER  : DIGIT+ ;

fragment DIGIT : [0-9] ;

// bỏ khoảng trắng
WS : [ \t\r\n]+ -> skip ;
