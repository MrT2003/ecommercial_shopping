# syntax_checker.py
# Vị trí: PPLPROJECT/CompiledFiles/grammar/syntax_checker.py

from antlr4 import InputStream, CommonTokenStream
from antlr4.error.ErrorListener import ErrorListener

from ..CompiledFiles.DrinkPreferenceLexer import DrinkPreferenceLexer
from ..CompiledFiles.DrinkPreferenceParser import DrinkPreferenceParser
from .drink_semantics import PreferenceVisitor

import os
print(">>> RUNNING:", __file__)
print(">>> CWD:", os.getcwd())


class CollectErrorListener(ErrorListener):
    def __init__(self):
        super().__init__()
        self.errors = []

    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        # Lưu mọi lỗi lexer + parser
        self.errors.append((line, column, msg))


def check_syntax(text: str):
    input_stream = InputStream(text)

    # ----- LEXER -----
    lexer = DrinkPreferenceLexer(input_stream)
    lex_err = CollectErrorListener()
    lexer.removeErrorListeners()
    lexer.addErrorListener(lex_err)

    tokens = CommonTokenStream(lexer)

    # ----- PARSER -----
    parser = DrinkPreferenceParser(tokens)
    parse_err = CollectErrorListener()
    parser.removeErrorListeners()
    parser.addErrorListener(parse_err)

    # start rule: program : request EOF ;
    tree = parser.program()

    errors = lex_err.errors + parse_err.errors
    if errors:
        return False, errors, None
    return True, [], tree


if __name__ == "__main__":
    while True:
        s = input("Input> ")
        if not s:
            break

        ok, errs, tree = check_syntax(s)

        if not ok:
            print("REJECT ❌ (sai grammar)")
            for line, col, msg in errs:
                print(f"  - line {line}, col {col}: {msg}")
            continue

        print("ACCEPT ✅ (đúng grammar)")

        # Gọi visitor để lấy meaning
        visitor = PreferenceVisitor()
        pref = visitor.visit(tree)      # tree = program
        print("→ Parsed preference:", pref)
