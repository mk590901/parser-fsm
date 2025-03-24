import '../../core/interfaces/i_transition_method.dart';
import '../client_helper.dart';
import 'parser_controller.dart';

class getNextChar implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@getNextChar $data");
    ClientHelper.instance()?.controller()?.getNewChar();
  }
}

class onInit implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@onInit $data");
    data?.call();
  }
}

class setError implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@setError $data");
    data?.call();
  }
}

class stop implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@stop $data");
    ClientHelper.instance()?.controller()?.tokens.trace('stop');
  }
}

class initToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@initToken $data");
    ClientHelper.instance()?.controller()?.initToken();
  }
}

class setTokenV1 implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@setTokenV1 $data");
    ClientHelper.instance()?.controller()?.setTokenV1();
    //data?.call();
  }
}

class setTokenV2 implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@setTokenV2 $data");
    ClientHelper.instance()?.controller()?.setTokenV2();
    //data?.call();
  }
}
class accumulateToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@accumulateToken $data");
    ClientHelper.instance()?.controller()?.accumulateToken();
  }
}

