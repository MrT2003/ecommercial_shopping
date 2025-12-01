from dataclasses import dataclass
from typing import Optional

from antlr4 import InputStream, CommonTokenStream

from ..CompiledFiles.DrinkPreferenceLexer import DrinkPreferenceLexer
from ..CompiledFiles.DrinkPreferenceParser import DrinkPreferenceParser
from ..CompiledFiles.DrinkPreferenceVisitor import DrinkPreferenceVisitor

# ----------------- 1. Định nghĩa "nghĩa" của 1 order -----------------

@dataclass
class DrinkPreference:
    temperature: Optional[str] = None   # hot / cold / warm / iced
    baseType: Optional[str] = None      # coffee / tea / milk tea / ...
    sweetness: Optional[str] = None     # no sugar / low sugar / ...
    caffeine: Optional[str] = None      # with caffeine / no caffeine / ...
    size: Optional[str] = None          # small / medium / large


# ----------------- 2. Visitor: lấy token trong tree ------------------

class PreferenceVisitor(DrinkPreferenceVisitor):
    def __init__(self):
        super().__init__()
        self.pref = DrinkPreference()

    # program : request EOF ;
    def visitProgram(self, ctx):
        return self.visit(ctx.request())

    # request : (prefix)* drinkPref (AND drinkPref)* ;
    # Hiện tại lấy drinkPref đầu tiên
    def visitRequest(self, ctx):
        first = ctx.drinkPref(0)
        return self.visit(first)

    # drinkPref : prorule (prorule)* ;
    def visitDrinkPref(self, ctx):
        for pr in ctx.prorule():
            self.visit(pr)
        return self.pref

    # prorule : temperature | baseType | sweetness | caffeine | size ;
    def visitProrule(self, ctx):
        if ctx.temperature():
            return self.visit(ctx.temperature())
        if ctx.baseType():
            return self.visit(ctx.baseType())
        if ctx.sweetness():
            return self.visit(ctx.sweetness())
        if ctx.caffeine():
            return self.visit(ctx.caffeine())
        if ctx.size():
            return self.visit(ctx.size())
        return self.pref

    # ---------- leaf rules ----------

    def visitTemperature(self, ctx):
        self.pref.temperature = ctx.getText().lower()
        return self.pref

    def visitBaseType(self, ctx):
        # "milk tea" -> "milk tea"
        self.pref.baseType = ctx.getText().lower()
        return self.pref

    def visitSweetness(self, ctx):
        self.pref.sweetness = ctx.getText().lower()
        return self.pref

    def visitCaffeine(self, ctx):
        self.pref.caffeine = ctx.getText().lower()
        return self.pref

    def visitSize(self, ctx):
        self.pref.size = ctx.getText().lower()
        return self.pref


# ----------------- 3. Hàm tiện: text → DrinkPreference -----------------

def parse_request(text: str) -> DrinkPreference:
    """
    Dùng riêng nếu muốn parse nhanh ngoài syntax_checker.
    Không check EOF chặt như program, chỉ parse request.
    """
    input_stream = InputStream(text)
    lexer = DrinkPreferenceLexer(input_stream)
    tokens = CommonTokenStream(lexer)
    parser = DrinkPreferenceParser(tokens)

    tree = parser.request()          # start rule trực tiếp

    visitor = PreferenceVisitor()
    pref = visitor.visit(tree)
    return pref


# ----------------- 4. Test CLI nhỏ -----------------

if __name__ == "__main__":
    while True:
        s = input("Request> ")
        if not s:
            break
        pref = parse_request(s)
        print(pref)
