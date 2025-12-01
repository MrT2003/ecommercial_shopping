# Generated from DrinkPreference.g4 by ANTLR 4.9.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
import sys
if sys.version_info[1] > 5:
	from typing import TextIO
else:
	from typing.io import TextIO


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\35")
        buf.write("Z\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b")
        buf.write("\t\b\4\t\t\t\4\n\t\n\4\13\t\13\3\2\3\2\3\2\3\3\7\3\33")
        buf.write("\n\3\f\3\16\3\36\13\3\3\3\3\3\3\3\7\3#\n\3\f\3\16\3&\13")
        buf.write("\3\3\4\3\4\3\4\3\4\5\4,\n\4\3\5\3\5\7\5\60\n\5\f\5\16")
        buf.write("\5\63\13\5\3\6\3\6\3\6\3\6\3\6\5\6:\n\6\3\7\3\7\3\b\3")
        buf.write("\b\3\b\3\b\3\b\3\b\5\bD\n\b\3\t\3\t\3\t\3\t\3\t\3\t\3")
        buf.write("\t\3\t\5\tN\n\t\3\n\3\n\3\n\3\n\3\n\3\n\5\nV\n\n\3\13")
        buf.write("\3\13\3\13\2\2\f\2\4\6\b\n\f\16\20\22\24\2\4\3\2\b\13")
        buf.write("\4\2\24\24\32\33\2`\2\26\3\2\2\2\4\34\3\2\2\2\6+\3\2\2")
        buf.write("\2\b-\3\2\2\2\n9\3\2\2\2\f;\3\2\2\2\16C\3\2\2\2\20M\3")
        buf.write("\2\2\2\22U\3\2\2\2\24W\3\2\2\2\26\27\5\4\3\2\27\30\7\2")
        buf.write("\2\3\30\3\3\2\2\2\31\33\5\6\4\2\32\31\3\2\2\2\33\36\3")
        buf.write("\2\2\2\34\32\3\2\2\2\34\35\3\2\2\2\35\37\3\2\2\2\36\34")
        buf.write("\3\2\2\2\37$\5\b\5\2 !\7\3\2\2!#\5\b\5\2\" \3\2\2\2#&")
        buf.write("\3\2\2\2$\"\3\2\2\2$%\3\2\2\2%\5\3\2\2\2&$\3\2\2\2\'(")
        buf.write("\7\4\2\2(,\7\5\2\2)*\7\6\2\2*,\7\7\2\2+\'\3\2\2\2+)\3")
        buf.write("\2\2\2,\7\3\2\2\2-\61\5\n\6\2.\60\5\n\6\2/.\3\2\2\2\60")
        buf.write("\63\3\2\2\2\61/\3\2\2\2\61\62\3\2\2\2\62\t\3\2\2\2\63")
        buf.write("\61\3\2\2\2\64:\5\f\7\2\65:\5\16\b\2\66:\5\20\t\2\67:")
        buf.write("\5\22\n\28:\5\24\13\29\64\3\2\2\29\65\3\2\2\29\66\3\2")
        buf.write("\2\29\67\3\2\2\298\3\2\2\2:\13\3\2\2\2;<\t\2\2\2<\r\3")
        buf.write("\2\2\2=D\7\f\2\2>D\7\r\2\2?D\7\16\2\2@A\7\17\2\2AD\7\r")
        buf.write("\2\2BD\7\20\2\2C=\3\2\2\2C>\3\2\2\2C?\3\2\2\2C@\3\2\2")
        buf.write("\2CB\3\2\2\2D\17\3\2\2\2EF\7\22\2\2FN\7\21\2\2GH\7\23")
        buf.write("\2\2HN\7\21\2\2IJ\7\24\2\2JN\7\21\2\2KL\7\25\2\2LN\7\21")
        buf.write("\2\2ME\3\2\2\2MG\3\2\2\2MI\3\2\2\2MK\3\2\2\2N\21\3\2\2")
        buf.write("\2OP\7\26\2\2PV\7\30\2\2QR\7\27\2\2RV\7\30\2\2ST\7\22")
        buf.write("\2\2TV\7\30\2\2UO\3\2\2\2UQ\3\2\2\2US\3\2\2\2V\23\3\2")
        buf.write("\2\2WX\t\3\2\2X\25\3\2\2\2\n\34$+\619CMU")
        return buf.getvalue()


class DrinkPreferenceParser ( Parser ):

    grammarFileName = "DrinkPreference.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [  ]

    symbolicNames = [ "<INVALID>", "AND", "I", "WANT", "GIVE", "ME", "HOT", 
                      "WARM", "COLD", "ICED", "COFFEE", "TEA", "JUICE", 
                      "MILK", "YOGURT", "SUGAR", "NO", "LOW", "MEDIUM", 
                      "HIGH", "WITH", "WITHOUT", "CAFFEINE", "UNDER", "SMALL", 
                      "LARGE", "NUMBER", "WS" ]

    RULE_program = 0
    RULE_request = 1
    RULE_prefix = 2
    RULE_drinkPref = 3
    RULE_prorule = 4
    RULE_temperature = 5
    RULE_baseType = 6
    RULE_sweetness = 7
    RULE_caffeine = 8
    RULE_size = 9

    ruleNames =  [ "program", "request", "prefix", "drinkPref", "prorule", 
                   "temperature", "baseType", "sweetness", "caffeine", "size" ]

    EOF = Token.EOF
    AND=1
    I=2
    WANT=3
    GIVE=4
    ME=5
    HOT=6
    WARM=7
    COLD=8
    ICED=9
    COFFEE=10
    TEA=11
    JUICE=12
    MILK=13
    YOGURT=14
    SUGAR=15
    NO=16
    LOW=17
    MEDIUM=18
    HIGH=19
    WITH=20
    WITHOUT=21
    CAFFEINE=22
    UNDER=23
    SMALL=24
    LARGE=25
    NUMBER=26
    WS=27

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.9.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class ProgramContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def request(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.RequestContext,0)


        def EOF(self):
            return self.getToken(DrinkPreferenceParser.EOF, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_program

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterProgram" ):
                listener.enterProgram(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitProgram" ):
                listener.exitProgram(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitProgram" ):
                return visitor.visitProgram(self)
            else:
                return visitor.visitChildren(self)




    def program(self):

        localctx = DrinkPreferenceParser.ProgramContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_program)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 20
            self.request()
            self.state = 21
            self.match(DrinkPreferenceParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class RequestContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def drinkPref(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(DrinkPreferenceParser.DrinkPrefContext)
            else:
                return self.getTypedRuleContext(DrinkPreferenceParser.DrinkPrefContext,i)


        def prefix(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(DrinkPreferenceParser.PrefixContext)
            else:
                return self.getTypedRuleContext(DrinkPreferenceParser.PrefixContext,i)


        def AND(self, i:int=None):
            if i is None:
                return self.getTokens(DrinkPreferenceParser.AND)
            else:
                return self.getToken(DrinkPreferenceParser.AND, i)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_request

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRequest" ):
                listener.enterRequest(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRequest" ):
                listener.exitRequest(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitRequest" ):
                return visitor.visitRequest(self)
            else:
                return visitor.visitChildren(self)




    def request(self):

        localctx = DrinkPreferenceParser.RequestContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_request)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 26
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==DrinkPreferenceParser.I or _la==DrinkPreferenceParser.GIVE:
                self.state = 23
                self.prefix()
                self.state = 28
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 29
            self.drinkPref()
            self.state = 34
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==DrinkPreferenceParser.AND:
                self.state = 30
                self.match(DrinkPreferenceParser.AND)
                self.state = 31
                self.drinkPref()
                self.state = 36
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class PrefixContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def I(self):
            return self.getToken(DrinkPreferenceParser.I, 0)

        def WANT(self):
            return self.getToken(DrinkPreferenceParser.WANT, 0)

        def GIVE(self):
            return self.getToken(DrinkPreferenceParser.GIVE, 0)

        def ME(self):
            return self.getToken(DrinkPreferenceParser.ME, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_prefix

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPrefix" ):
                listener.enterPrefix(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPrefix" ):
                listener.exitPrefix(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPrefix" ):
                return visitor.visitPrefix(self)
            else:
                return visitor.visitChildren(self)




    def prefix(self):

        localctx = DrinkPreferenceParser.PrefixContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_prefix)
        try:
            self.state = 41
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [DrinkPreferenceParser.I]:
                self.enterOuterAlt(localctx, 1)
                self.state = 37
                self.match(DrinkPreferenceParser.I)
                self.state = 38
                self.match(DrinkPreferenceParser.WANT)
                pass
            elif token in [DrinkPreferenceParser.GIVE]:
                self.enterOuterAlt(localctx, 2)
                self.state = 39
                self.match(DrinkPreferenceParser.GIVE)
                self.state = 40
                self.match(DrinkPreferenceParser.ME)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class DrinkPrefContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def prorule(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(DrinkPreferenceParser.ProruleContext)
            else:
                return self.getTypedRuleContext(DrinkPreferenceParser.ProruleContext,i)


        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_drinkPref

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDrinkPref" ):
                listener.enterDrinkPref(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDrinkPref" ):
                listener.exitDrinkPref(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDrinkPref" ):
                return visitor.visitDrinkPref(self)
            else:
                return visitor.visitChildren(self)




    def drinkPref(self):

        localctx = DrinkPreferenceParser.DrinkPrefContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_drinkPref)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 43
            self.prorule()
            self.state = 47
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << DrinkPreferenceParser.HOT) | (1 << DrinkPreferenceParser.WARM) | (1 << DrinkPreferenceParser.COLD) | (1 << DrinkPreferenceParser.ICED) | (1 << DrinkPreferenceParser.COFFEE) | (1 << DrinkPreferenceParser.TEA) | (1 << DrinkPreferenceParser.JUICE) | (1 << DrinkPreferenceParser.MILK) | (1 << DrinkPreferenceParser.YOGURT) | (1 << DrinkPreferenceParser.NO) | (1 << DrinkPreferenceParser.LOW) | (1 << DrinkPreferenceParser.MEDIUM) | (1 << DrinkPreferenceParser.HIGH) | (1 << DrinkPreferenceParser.WITH) | (1 << DrinkPreferenceParser.WITHOUT) | (1 << DrinkPreferenceParser.SMALL) | (1 << DrinkPreferenceParser.LARGE))) != 0):
                self.state = 44
                self.prorule()
                self.state = 49
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ProruleContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def temperature(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.TemperatureContext,0)


        def baseType(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.BaseTypeContext,0)


        def sweetness(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.SweetnessContext,0)


        def caffeine(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.CaffeineContext,0)


        def size(self):
            return self.getTypedRuleContext(DrinkPreferenceParser.SizeContext,0)


        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_prorule

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterProrule" ):
                listener.enterProrule(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitProrule" ):
                listener.exitProrule(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitProrule" ):
                return visitor.visitProrule(self)
            else:
                return visitor.visitChildren(self)




    def prorule(self):

        localctx = DrinkPreferenceParser.ProruleContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_prorule)
        try:
            self.state = 55
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,4,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 50
                self.temperature()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 51
                self.baseType()
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 52
                self.sweetness()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 53
                self.caffeine()
                pass

            elif la_ == 5:
                self.enterOuterAlt(localctx, 5)
                self.state = 54
                self.size()
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class TemperatureContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def HOT(self):
            return self.getToken(DrinkPreferenceParser.HOT, 0)

        def WARM(self):
            return self.getToken(DrinkPreferenceParser.WARM, 0)

        def COLD(self):
            return self.getToken(DrinkPreferenceParser.COLD, 0)

        def ICED(self):
            return self.getToken(DrinkPreferenceParser.ICED, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_temperature

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTemperature" ):
                listener.enterTemperature(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTemperature" ):
                listener.exitTemperature(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTemperature" ):
                return visitor.visitTemperature(self)
            else:
                return visitor.visitChildren(self)




    def temperature(self):

        localctx = DrinkPreferenceParser.TemperatureContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_temperature)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 57
            _la = self._input.LA(1)
            if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << DrinkPreferenceParser.HOT) | (1 << DrinkPreferenceParser.WARM) | (1 << DrinkPreferenceParser.COLD) | (1 << DrinkPreferenceParser.ICED))) != 0)):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class BaseTypeContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def COFFEE(self):
            return self.getToken(DrinkPreferenceParser.COFFEE, 0)

        def TEA(self):
            return self.getToken(DrinkPreferenceParser.TEA, 0)

        def JUICE(self):
            return self.getToken(DrinkPreferenceParser.JUICE, 0)

        def MILK(self):
            return self.getToken(DrinkPreferenceParser.MILK, 0)

        def YOGURT(self):
            return self.getToken(DrinkPreferenceParser.YOGURT, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_baseType

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBaseType" ):
                listener.enterBaseType(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBaseType" ):
                listener.exitBaseType(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBaseType" ):
                return visitor.visitBaseType(self)
            else:
                return visitor.visitChildren(self)




    def baseType(self):

        localctx = DrinkPreferenceParser.BaseTypeContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_baseType)
        try:
            self.state = 65
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [DrinkPreferenceParser.COFFEE]:
                self.enterOuterAlt(localctx, 1)
                self.state = 59
                self.match(DrinkPreferenceParser.COFFEE)
                pass
            elif token in [DrinkPreferenceParser.TEA]:
                self.enterOuterAlt(localctx, 2)
                self.state = 60
                self.match(DrinkPreferenceParser.TEA)
                pass
            elif token in [DrinkPreferenceParser.JUICE]:
                self.enterOuterAlt(localctx, 3)
                self.state = 61
                self.match(DrinkPreferenceParser.JUICE)
                pass
            elif token in [DrinkPreferenceParser.MILK]:
                self.enterOuterAlt(localctx, 4)
                self.state = 62
                self.match(DrinkPreferenceParser.MILK)
                self.state = 63
                self.match(DrinkPreferenceParser.TEA)
                pass
            elif token in [DrinkPreferenceParser.YOGURT]:
                self.enterOuterAlt(localctx, 5)
                self.state = 64
                self.match(DrinkPreferenceParser.YOGURT)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class SweetnessContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NO(self):
            return self.getToken(DrinkPreferenceParser.NO, 0)

        def SUGAR(self):
            return self.getToken(DrinkPreferenceParser.SUGAR, 0)

        def LOW(self):
            return self.getToken(DrinkPreferenceParser.LOW, 0)

        def MEDIUM(self):
            return self.getToken(DrinkPreferenceParser.MEDIUM, 0)

        def HIGH(self):
            return self.getToken(DrinkPreferenceParser.HIGH, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_sweetness

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSweetness" ):
                listener.enterSweetness(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSweetness" ):
                listener.exitSweetness(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSweetness" ):
                return visitor.visitSweetness(self)
            else:
                return visitor.visitChildren(self)




    def sweetness(self):

        localctx = DrinkPreferenceParser.SweetnessContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_sweetness)
        try:
            self.state = 75
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [DrinkPreferenceParser.NO]:
                self.enterOuterAlt(localctx, 1)
                self.state = 67
                self.match(DrinkPreferenceParser.NO)
                self.state = 68
                self.match(DrinkPreferenceParser.SUGAR)
                pass
            elif token in [DrinkPreferenceParser.LOW]:
                self.enterOuterAlt(localctx, 2)
                self.state = 69
                self.match(DrinkPreferenceParser.LOW)
                self.state = 70
                self.match(DrinkPreferenceParser.SUGAR)
                pass
            elif token in [DrinkPreferenceParser.MEDIUM]:
                self.enterOuterAlt(localctx, 3)
                self.state = 71
                self.match(DrinkPreferenceParser.MEDIUM)
                self.state = 72
                self.match(DrinkPreferenceParser.SUGAR)
                pass
            elif token in [DrinkPreferenceParser.HIGH]:
                self.enterOuterAlt(localctx, 4)
                self.state = 73
                self.match(DrinkPreferenceParser.HIGH)
                self.state = 74
                self.match(DrinkPreferenceParser.SUGAR)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class CaffeineContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def WITH(self):
            return self.getToken(DrinkPreferenceParser.WITH, 0)

        def CAFFEINE(self):
            return self.getToken(DrinkPreferenceParser.CAFFEINE, 0)

        def WITHOUT(self):
            return self.getToken(DrinkPreferenceParser.WITHOUT, 0)

        def NO(self):
            return self.getToken(DrinkPreferenceParser.NO, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_caffeine

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCaffeine" ):
                listener.enterCaffeine(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCaffeine" ):
                listener.exitCaffeine(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitCaffeine" ):
                return visitor.visitCaffeine(self)
            else:
                return visitor.visitChildren(self)




    def caffeine(self):

        localctx = DrinkPreferenceParser.CaffeineContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_caffeine)
        try:
            self.state = 83
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [DrinkPreferenceParser.WITH]:
                self.enterOuterAlt(localctx, 1)
                self.state = 77
                self.match(DrinkPreferenceParser.WITH)
                self.state = 78
                self.match(DrinkPreferenceParser.CAFFEINE)
                pass
            elif token in [DrinkPreferenceParser.WITHOUT]:
                self.enterOuterAlt(localctx, 2)
                self.state = 79
                self.match(DrinkPreferenceParser.WITHOUT)
                self.state = 80
                self.match(DrinkPreferenceParser.CAFFEINE)
                pass
            elif token in [DrinkPreferenceParser.NO]:
                self.enterOuterAlt(localctx, 3)
                self.state = 81
                self.match(DrinkPreferenceParser.NO)
                self.state = 82
                self.match(DrinkPreferenceParser.CAFFEINE)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class SizeContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SMALL(self):
            return self.getToken(DrinkPreferenceParser.SMALL, 0)

        def MEDIUM(self):
            return self.getToken(DrinkPreferenceParser.MEDIUM, 0)

        def LARGE(self):
            return self.getToken(DrinkPreferenceParser.LARGE, 0)

        def getRuleIndex(self):
            return DrinkPreferenceParser.RULE_size

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSize" ):
                listener.enterSize(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSize" ):
                listener.exitSize(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSize" ):
                return visitor.visitSize(self)
            else:
                return visitor.visitChildren(self)




    def size(self):

        localctx = DrinkPreferenceParser.SizeContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_size)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 85
            _la = self._input.LA(1)
            if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << DrinkPreferenceParser.MEDIUM) | (1 << DrinkPreferenceParser.SMALL) | (1 << DrinkPreferenceParser.LARGE))) != 0)):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





