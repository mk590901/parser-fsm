// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:parser/client_helper.dart';
import 'package:parser/parser_state_machine/operators.dart';
import 'package:parser/parser_state_machine/parser_controller.dart';

void main() {
// All tests
  test('ParserController', () {
    ClientHelper.initInstance();
    ParserController parserController = ParserController('ZwLight.Brightness >= 50', Operators());
    expect(parserController,isNotNull);
    ClientHelper.instance()?.setController(parserController);
    parserController.parse();
    // int x = 0;
    // int y = x;
  });

}
