

import 'dart:collection';
import 'dart:core';

import '../core/event.dart';
import 'interfaces.dart';
import 'operators.dart';
import 'parser_bloc.dart';
import 'parser_events.dart';
import 'parser_state_machine.dart';
import 'parser_states.dart';

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
  //ParserBloc? bloc;

  //final Queue<Event>	_eventsQueue	= Queue<Event>();

  ParserController(this.source, Operators this.operators) {
    //bloc = ParserBloc(this, ParserState(ParserStates.IDLE));
    stateMachine = ParserStateMachine(ParserStates.IDLE.index);
    (stateMachine as ParserStateMachine).setController(this);
    init();
  }

  String? getSource() => source;

  int getIndex() => index;

  void setIndex(int index) {
    this.index = index;
  }

  String getCurrentChar() {
    //print ('ParserController.getCurrentChar->[$currentChar]');
    return currentChar;
  }

  void setCurrentChar(String currentChar) {
    this.currentChar = currentChar;
    //print ('ParserController.setCurrentChar->[$currentChar]');
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
    trace('ParserController.setToken  [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    //stateMachine?.postEvent(NextChar());
    //bloc?.add(NextChar());
    stateMachine?.postEvent(NextChar());
  }

  void setToken2() {
    trace2('ParserController.setToken2 [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    setIndex(getIndex() - 1);
    //stateMachine?.postEvent(NextChar());
    //bloc?.add(NextChar());
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
    //stateMachine?.postEvent(checkCharacter(getCurrentChar()));
    //bloc?.add(checkCharacter(getCurrentChar()));
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
    //trace("ParserController.getNewChar [$index]");
    if (index >= source.length) {
      trace("ParserController.getNewChar->[EOL]");
      //stateMachine?.postEvent(Eol());
      //bloc?.add(Eol());
      stateMachine?.postEvent(Eol());
      return;
    }
    setCurrentChar(source[index]);
    index++;
    Event testEvent = checkCharacter(getCurrentChar());
    //print('testEvent->[$testEvent]');
    //bloc?.add(testEvent);
    stateMachine?.postEvent(testEvent);
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

  void parse() {
    //bloc?.add(NextChar());
    stateMachine?.postEvent(NextChar());
  }

  // void postEvent(Event event) {
  //   //print('post.addQueue [$event($data)]');
  //   //scheduleMicrotask(() {  //  ?
  //   _eventsQueue.add(event);
  //   while (_eventsQueue.isNotEmpty) {
  //     Event event_ = _eventsQueue.removeFirst();
  //     //print('post event [${eventWrapper.event()}, ${eventWrapper.data()}]');
  //     bloc?.add(event_);
  //     //print ('postEvent->[$event]');
  //   }
  //   //}); //  ?
  // }


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

