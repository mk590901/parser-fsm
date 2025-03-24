import '../interfaces.dart';

class TokenOperator extends Token {
  IOperation? operation;

  TokenOperator(String name) : super(name, Type.Operator);

  @override
  bool isOperand() {
    return false;
  }

  @override
  bool isOperator() {
    return true;
  }

  @override
  bool isConstant() {
    return false;
  }

  @override
  bool isVariable() {
    return false;
  }
}

class Token {
  String name;
  Type type;

  Token(this.name, this.type);

  String getName() => name;

  void setName(String name) {
    this.name = name;
  }

  Type getType() => type;

  void setType(Type type) {
    this.type = type;
  }

  String toText() {
    return '${getName().padRight(24)}\t${getType()}';
  }

  bool isOperand() => false;

  bool isOperator() => false;

  bool isConstant() => false;

  bool isVariable() => false;
}

