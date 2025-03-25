import '../interfaces.dart';
import 'token.dart';

class TokenOperator extends Token {

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
