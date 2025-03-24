import '../interfaces.dart';

class TokenConstant extends Token {
  TokenConstant(String name) : super(name, Type.Operand);

  @override
  String toText() {
    return '${getName().padRight(24)}\t${getType()}\tConstant';
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
    return true;
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

  bool isOperand() => true;

  bool isOperator() => false;

  bool isConstant() => true;

  bool isVariable() => false;
}
