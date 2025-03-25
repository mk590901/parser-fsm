import '../../core/interfaces/i_transition_method.dart';

class getNextChar implements ITransitionMethod {
  @override
  void execute([var data]) {
    data?.getNewChar();
  }
}

class onInit implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@onInit $data");
    //data?.call();
  }
}

class setError implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@setError $data");
    //data?.call();
  }
}

class stop implements ITransitionMethod {
  @override
  void execute([var data]) {
    data?.tokens.trace('stop');
    data?.dispose();
  }
}

class initToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    data?.initToken();
  }
}

class setTokenV1 implements ITransitionMethod {
  @override
  void execute([var data]) {
    data?.setTokenV1();
  }
}

class setTokenV2 implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@setTokenV2 $data");
    //ClientHelper.instance()?.controller()?.setTokenV2();
    //data?.call();
    data?.setTokenV2();
  }
}
class accumulateToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@accumulateToken $data");
    //ClientHelper.instance()?.controller()?.accumulateToken();
    data?.accumulateToken();
  }
}

