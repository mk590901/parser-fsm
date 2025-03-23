import '../../core/interfaces/i_transition_method.dart';

class getNextChar implements ITransitionMethod {
  @override
  void execute([var hashMap]) {
    print("@getNextChar $hashMap");
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
    print("@initToken $data");
  }
}

class setToken implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@setToken $data");
    data?.call();
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
    print("@accumulateToken $data");
  }
}

class OnSuccess implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnSuccess $data");
    data?.call();
  }
}

class OnUp implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnUp $data");
  }
}

class OnDisableOff implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnDisableOff $data");
  }
}

class OnDisableOn implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnDisableOn $data");
  }
}

class OnEnableOff implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnEnableOff $data");
  }
}

class OnEnableOn implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnEnableOn $data");
  }
}

class OnDisable implements ITransitionMethod {
  @override
  void execute([var data]) {
    //print("@OnDisable $data");
  }
}

class OnEnable implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnEnable $data");
  }
}

class OnPress implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnPress $data");
  }
}

class OnUnpress implements ITransitionMethod {
  @override
  void execute([var data]) {
    print("@OnUnpress $data");
  }
}

