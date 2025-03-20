//  Parser events
import '../../core/event.dart';

/*
        Eol,
        InvalidChar,
        InvisibleChar,
        ValidChar,
        KeywordChar,
        DetectToken,
        NextChar,
        Init;

 */

class Eol<T> extends Event<T> {
  T? _data;
  Eol([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Eol<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class InvalidChar<T> extends Event<T> {
  T? _data;
  InvalidChar([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  InvalidChar<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class InvisibleChar<T> extends Event<T> {
  T? _data;
  InvisibleChar([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  InvisibleChar<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class ValidChar<T> extends Event<T> {
  T? _data;
  ValidChar([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  ValidChar<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class KeywordChar<T> extends Event<T> {
  T? _data;
  KeywordChar([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  KeywordChar<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class DetectToken<T> extends Event<T> {
  T? _data;
  DetectToken([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  DetectToken<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class NextChar<T> extends Event<T> {
  T? _data;
  NextChar([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  NextChar<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Init<T> extends Event<T> {
  T? _data;
  Init([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Init<T> setData([T? data]) {
    _data = data;
    return this;
  }
}



