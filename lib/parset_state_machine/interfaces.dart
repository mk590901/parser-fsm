abstract class IFunctor {
  void execute();
}

abstract class IOperation {
  String execute(List<String> parameters);
}

enum OperationType {
  Unknown,
  BinaryOperation,
  UnaryOperation,
}

abstract class IToken {
  String getName();
  void setName(String name);
  Type getType();
  void setType(Type type);

  String toText();

  bool isOperand();
  bool isOperator();
  bool isConstant();
  bool isVariable();
}

enum Type {
  Unknown,
  Operand,
  Operator,
}
