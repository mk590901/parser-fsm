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
  }
}

class initToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@initToken $data");
    ClientHelper.instance()?.controller()?.initToken();
  }
}

class setToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@setToken $data");
    ClientHelper.instance()?.controller()?.setToken_();
    //data?.call();
  }
}

class setToken2 implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@setToken2 $data");
    data?.call();
  }
}
class accumulateToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@accumulateToken $data");
    ClientHelper.instance()?.controller()?.accumulateToken();
  }
}

