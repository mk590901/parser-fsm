import '../interfaces.dart';

class TokenVariable extends Token {
  TokenVariable(String name) : super(name, Type.Operand);

  @override
  String toText() {
    return '${getName().padRight(24)}\t${getType()}\tVariable';
  }

  @override
  bool isOperand() {
    return true;
  }

  @override
  bool isOperator() {
    return false;
  }

  @override
  bool isConstant() {
    return false;
  }

  @override
  bool isVariable() {
    return true;
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

  bool isVariable() => true;
}

