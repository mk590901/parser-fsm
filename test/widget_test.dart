// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:parser/parser_state_machine/operators.dart';
import 'package:parser/parser_state_machine/parser_controller.dart';

void main() {
// All tests
  test('ParserController One', () async {
    ParserController parserController = ParserController('ZwLight.Brightness >= 50', Operators());
    expect(parserController,isNotNull);
    parserController.parse();

    await Future.delayed(Duration(seconds: 1));

    expect(parserController.tokens.size(),3);

  });

  test('ParserController Two', () async {
    ParserController parserController = ParserController('ZwLight.Brightness >= (50+4*8-BLE.Light.Brightness)', Operators());
    expect(parserController,isNotNull);
    parserController.parse();

    await Future.delayed(Duration(seconds: 1));

    //expect(parserController.tokens.size(),3);
/*
D: ParserController - ParserController.Init->[ZwLight.Brightness >= (50+4*8-BLE.Light.Brightness)]
D: ParserController - ParserController.setTokenV1  [ZwLight.Brightness](Operand)
D: ParserController - ParserController.setTokenV1  [>=](Operator)
D: ParserController - ParserController.setTokenV2 [(](Operator)
D: ParserController - ParserController.setTokenV2 [50](Operand)
D: ParserController - ParserController.setTokenV2 [+](Operator)
D: ParserController - ParserController.setTokenV2 [4](Operand)
D: ParserController - ParserController.setTokenV2 [*](Operator)
D: ParserController - ParserController.setTokenV2 [8](Operand)
D: ParserController - ParserController.setTokenV2 [-](Operator)
D: ParserController - ParserController.setTokenV2 [BLE.Light.Brightness](Operand)
D: ParserController - ParserController.getNewChar->[EOL]
D: ParserController - ParserController.setTokenV1  [)](Operator)
D: ParserController - ParserController.getNewChar->[EOL]
------- stop -------
( 0)	ZwLight.Brightness      	Type.Operand	Variable
( 1)	>=                      	Type.Operator	Operator
( 2)	(                       	Type.Operator	Operator
( 3)	50                      	Type.Operand	Constant
( 4)	+                       	Type.Operator	Operator
( 5)	4                       	Type.Operand	Constant
( 6)	*                       	Type.Operator	Operator
( 7)	8                       	Type.Operand	Constant
( 8)	-                       	Type.Operator	Operator
( 9)	BLE.Light.Brightness    	Type.Operand	Variable
(10)	)                       	Type.Operator	Operator
+++++++ stop +++++++
BasicStateMachine.dispose

 */
  });

}
