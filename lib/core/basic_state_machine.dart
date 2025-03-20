import '../core/event.dart';
import '../core/state.dart';
import 'transaction.dart';

typedef IntFilter = int Function(int targetState, Event event, int previousState);

abstract class BasicStateMachine {
  late int _currentState;
  late int _previousState = -1;

  late IntFilter? filter;
  final Map<int, State> states_ = <int, State>{};

//  Constructor
  BasicStateMachine(this._currentState) {
    filter = null;
    setFilter();
    create();
  }

  int dispatch(Event event) {
    State? stateEntity = states_[_currentState];
    if (stateEntity == null || stateEntity.size() == 0) {
      print("Failed to get State [${getStateName(_currentState)}]");
      return -1;
    }

    Transaction? transaction = stateEntity.transaction(event);
    if (transaction == null) {
      print(
          """
Failed to get transaction for [${getStateName(_currentState)}], event->$event""");
      return -1;
    }
    //_previousState = _currentState;
    int tempState = _currentState;

    _currentState = (filter == null)
        ? transaction.state()
        : filter!(transaction.state(), event, _previousState);

    _previousState = tempState;

    //_currentState = transaction.state();

    transaction.method()?.execute(event.getData());
    return _currentState;
  }

  void create(); //  abstract function
  void publishState(int state); //  abstract function
  void publishEvent(Event event); //  abstract function
  String? getStateName(int state); //  abstract function
  String? getEventName(int event); //  abstract function
  void setFilter();

  int state() {
    return _currentState;
  }

  int previousState() {
    return _previousState;
  }

  void setState(int state) {
    _currentState = state;
  }
}
