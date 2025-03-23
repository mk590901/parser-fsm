enum ParserStates {
  IDLE,
  WAIT_NEXT_CHAR,
  ACCUMULATE_TOKEN,
  ACCUMULATE_KEYWORD,
  END_TOKEN,
  ERROR,
  STOP
}

class ParserState<T> {

  static int state_(ParserStates state) {
    return state.index;
  }

  final ParserStates _state;
  T? _data;

  ParserState(this._state) {
    _data = null;
  }

  ParserStates state() {
    return _state;
  }

  void setData(T? data) {
    _data = data;
  }

  T? data() {
    return _data;
  }
}
