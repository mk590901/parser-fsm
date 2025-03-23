

import 'dart:core';

import '../core/event.dart';
import 'interfaces.dart';
import 'operators.dart';
import 'parser_events.dart';
import 'parser_state_machine.dart';

class ParserController {
  static const String TAG = "ParserController";

  String? source;
  int index = 0;
  String currentChar = '\0';
  String token = "";
  Operators? operators;
  IFunctor? result;
  Tokens tokens = Tokens();
  ParserStateMachine? stateMachine;

  ParserController(String sourceLine, Operators this.operators) {
    source = sourceLine;
    init();
  }

  ParserStateMachine? getStateMachine() => stateMachine;

  void setStateMachine(ParserStateMachine stateMachine) {
    this.stateMachine = stateMachine;
  }

  String? getSource() => source;

  void setSource(String source) {
    this.source = source;
  }

  int getIndex() => index;

  void setIndex(int index) {
    this.index = index;
  }

  String getCurrentChar() => currentChar;

  void setCurrentChar(String currentChar) {
    this.currentChar = currentChar;
  }

  String getToken() => token;

  void setToken(String token) {
    this.token = token;
  }

  void addToken(String symbol) {
    token += symbol;
  }

  IFunctor? getResult() => result;

  void setResult(IFunctor result) {
    this.result = result;
  }

  Operators? getOperators() => operators;

  void setOperators(Operators operators) {
    this.operators = operators;
  }

  void trace(String message) {
    // Log.d(TAG, message);
    print('DEBUG: $TAG - $message');
  }

  void trace2(String message) {
    // Log.e(TAG, message);
    print('ERROR: $TAG - $message');
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

  void setToken_() {
    trace2('ParserController.setToken  [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    stateMachine?.postEvent(NextChar());
  }

  void setToken2() {
    trace2('ParserController.setToken2 [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    setIndex(getIndex() - 1);
    stateMachine?.postEvent(NextChar());
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
    if (index >= source!.length) {
      trace("ParserController.getNewChar->[EOL]");
      stateMachine?.postEvent(Eol());
      return;
    }
    setCurrentChar(source![index]);
    index++;
    Event test = checkCharacter(getCurrentChar());
    stateMachine?.postEvent(test);
  }

  Event checkCharacter(String currentChar) {
    if (currentChar.codeUnitAt(0) <= 32) {
      return Eol();
    } else if (charIsKeywordChar(currentChar)) {
      return KeywordChar();
    } else {
      return ValidChar();
    }
  }

  // Event getEvent(int what) {
  //   return Event.getEvent(what);
  // }

  Tokens getTokens() {
    return tokens;
  }
}

// Assuming these classes/methods are defined somewhere in your code
// class ParserStateMachine {
//   void postEvent(Event event) {
//     // Implementation here
//   }
// }

// class IFunctor {
//   void execute() {
//     // Implementation here
//   }
//}

class Tokens {
  void add(IToken token) {
    // Implementation here
  }
}

class TokenOperator implements IToken {
  String name;
  TokenOperator(this.name);

  @override
  String getName() => name;

  @override
  void setName(String name) {
    this.name = name;
  }

  @override
  Type getType() => Type.Operator;

  @override
  void setType(Type type) {
    // No-op for this implementation
  }

  @override
  String toText() => name;

  @override
  bool isOperand() => false;

  @override
  bool isOperator() => true;

  @override
  bool isConstant() => false;

  @override
  bool isVariable() => false;
}

class TokenVariable implements IToken {
  String name;
  TokenVariable(this.name);

  @override
  String getName() => name;

  @override
  void setName(String name) {
    this.name = name;
  }

  @override
  Type getType() => Type.Operand;

  @override
  void setType(Type type) {
    // No-op for this implementation
  }

  @override
  String toText() => name;

  @override
  bool isOperand() => true;

  @override
  bool isOperator() => false;

  @override
  bool isConstant() => false;

  @override
  bool isVariable() => true;
}

class TokenConstant implements IToken {
  String name;
  TokenConstant(this.name);

  @override
  String getName() => name;

  @override
  void setName(String name) {
    this.name = name;
  }

  @override
  Type getType() => Type.Operand;

  @override
  void setType(Type type) {
    // No-op for this implementation
  }

  @override
  String toText() => name;

  @override
  bool isOperand() => true;

  @override
  bool isOperator() => false;

  @override
  bool isConstant() => true;

  @override
  bool isVariable() => false;
}

