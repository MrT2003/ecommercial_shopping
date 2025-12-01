# Generated from DrinkPreference.g4 by ANTLR 4.9.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .DrinkPreferenceParser import DrinkPreferenceParser
else:
    from DrinkPreferenceParser import DrinkPreferenceParser

# This class defines a complete generic visitor for a parse tree produced by DrinkPreferenceParser.

class DrinkPreferenceVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by DrinkPreferenceParser#program.
    def visitProgram(self, ctx:DrinkPreferenceParser.ProgramContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#request.
    def visitRequest(self, ctx:DrinkPreferenceParser.RequestContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#prefix.
    def visitPrefix(self, ctx:DrinkPreferenceParser.PrefixContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#drinkPref.
    def visitDrinkPref(self, ctx:DrinkPreferenceParser.DrinkPrefContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#prorule.
    def visitProrule(self, ctx:DrinkPreferenceParser.ProruleContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#temperature.
    def visitTemperature(self, ctx:DrinkPreferenceParser.TemperatureContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#baseType.
    def visitBaseType(self, ctx:DrinkPreferenceParser.BaseTypeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#sweetness.
    def visitSweetness(self, ctx:DrinkPreferenceParser.SweetnessContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#caffeine.
    def visitCaffeine(self, ctx:DrinkPreferenceParser.CaffeineContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by DrinkPreferenceParser#size.
    def visitSize(self, ctx:DrinkPreferenceParser.SizeContext):
        return self.visitChildren(ctx)



del DrinkPreferenceParser