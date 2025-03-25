import 'dart:core';
import '../core/basic_state_machine.dart';
import '../core/event.dart';
import 'interfaces.dart';
import 'operators.dart';
import 'parser_events.dart';
import 'parser_state_machine.dart';
import 'parser_states.dart';
import 'tokens/token_constant.dart';
import 'tokens/token_operator.dart';
import 'tokens/token_variable.dart';
import 'tokens/tokens.dart';

class ParserController {
  static const String TAG = "ParserController";

  final String source;
  int index = 0;
  String currentChar = '';
  String token = "";
  final Operators? operators;
  IFunctor? result;
  Tokens tokens = Tokens();

  ParserStateMachine? stateMachine;// = ParserStateMachine(ParserStates.IDLE.index);

  ParserController(this.source, Operators this.operators) {
    stateMachine = ParserStateMachine(ParserStates.IDLE.index);
    stateMachine?.setController(this);
    init();
  }

  void dispose() {
    stateMachine?.dispose();
  }

  String? getSource() => source;

  int getIndex() => index;

  void setIndex(int index) {
    this.index = index;
  }

  String getCurrentChar() {
    return currentChar;
  }

  void setCurrentChar(String currentChar) {
    this.currentChar = currentChar;
  }

  String getToken() => token;

  void setToken(String token) {
    this.token = token;
  }

  void addToken(String symbol) {
    token += symbol;
    //print ('addToken->[$token]');
  }

  IFunctor? getResult() => result;

  void setResult(IFunctor result) {
    this.result = result;
  }

  Operators? getOperators() => operators;

  void trace(String message) {
     print('D: $TAG - $message');
  }

  void trace2(String message) {
    print('D: $TAG - $message');
  }

  void init() {
    trace('ParserController.Init->[$source]');
    setIndex(0);
  }

  void stopParsing() {
    setIndex(0);
    result?.execute();
  }

  void accumulateToken() {
    addToken(getCurrentChar());
    getNewChar();
  }

  bool tokenIsKeyword(String token) {
    return operators?.contains(token) ?? false;
  }

  bool charIsKeywordChar(String symbol) {
    return operators?.containsPartially(symbol) ?? false;
  }

  void setTokenV1() {
    trace('ParserController.setTokenV1  [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    stateMachine?.postEvent(NextChar(this));
  }

  void setTokenV2() {
    trace2('ParserController.setTokenV2 [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    setIndex(getIndex() - 1);
    stateMachine?.postEvent(NextChar(this));
  }

  IToken createToken(String tokenName) {
    IToken? result;
    Type tokenType = getTokenTypeEnum(tokenName);
    if (tokenType == Type.Operator) {
      result = TokenOperator(tokenName);
    } else {
      if (tokenName.contains(".")) {
        result = TokenVariable(tokenName);
      } else {
        result = TokenConstant(tokenName);
      }
    }
    return result;
  }

  String getTokenType(String token) {
    return tokenIsKeyword(token) ? "Operator" : "Operand";
  }

  Type getTokenTypeEnum(String token) {
    return tokenIsKeyword(token) ? Type.Operator : Type.Operand;
  }

  void initToken() {
    setToken("");
    stateMachine?.postEvent(checkCharacter(getCurrentChar()));
  }

  void stop() {
    trace("ParserController.stop");
    stopParsing();
  }

  void setError() {
    trace("ParserController.setError");
  }

  void getNewChar() {
    if (index >= source.length) {
      trace("ParserController.getNewChar->[EOL]");
      stateMachine?.postEvent(Eol(this));
      return;
    }
    setCurrentChar(source[index]);
    index++;
    Event testEvent = checkCharacter(getCurrentChar());
    stateMachine?.postEvent(testEvent);
  }

  Event checkCharacter(String currentChar) {
    if (currentChar.codeUnitAt(0) <= 32) {
      return Eol(this);
    } else if (charIsKeywordChar(currentChar)) {
      return KeywordChar(this);
    } else {
      return ValidChar(this);
    }
  }

  Tokens getTokens() {
    return tokens;
  }

  void parse() {
    stateMachine?.postEvent(NextChar(this));
  }
}
