import 'dart:async';

import '../../core/basic_state_machine.dart';
import '../../core/event.dart';
import '../../core/state.dart';
import '../../core/trans.dart';
import 'parser_controller.dart';
import 'parser_trans_methods.dart';
import 'parser_events.dart';
import 'parser_states.dart';

class ParserStateMachine extends BasicStateMachine {
  ParserController? controller;

  ParserStateMachine(super.currentState);

  void setController(ParserController? controller) {
    this.controller = controller;
  }

  @override
  void create() {

    states_ [ParserState.state_(ParserStates.IDLE)]           = State([ Trans(NextChar(),       ParserState.state_(ParserStates.WAIT_NEXT_CHAR),    getNextChar()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.IDLE),              onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.WAIT_NEXT_CHAR)]  = State([ Trans(InvisibleChar(),  ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     getNextChar()),
                                                                        Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                        Trans(Eol(),            ParserState.state_(ParserStates.STOP),               stop()),
                                                                        Trans(ValidChar(),      ParserState.state_(ParserStates.ACCUMULATE_TOKEN),   initToken()),
                                                                        Trans(KeywordChar(),    ParserState.state_(ParserStates.ACCUMULATE_KEYWORD), initToken()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.ACCUMULATE_TOKEN)]= State([ Trans(InvisibleChar(),  ParserState.state_(ParserStates.END_TOKEN),          setTokenV1()),
                                                                        Trans(KeywordChar(),    ParserState.state_(ParserStates.END_TOKEN),          setTokenV2()),
                                                                        Trans(Eol(),            ParserState.state_(ParserStates.END_TOKEN),          setTokenV1()),
                                                                        Trans(DetectToken(),    ParserState.state_(ParserStates.END_TOKEN),          setTokenV1()),
                                                                        Trans(ValidChar(),      ParserState.state_(ParserStates.ACCUMULATE_TOKEN),   accumulateToken()),
                                                                        Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.ACCUMULATE_KEYWORD)] = State([Trans(InvisibleChar(),  ParserState.state_(ParserStates.END_TOKEN),        setTokenV1()),
                                                                          Trans(KeywordChar(),    ParserState.state_(ParserStates.ACCUMULATE_KEYWORD), accumulateToken()),
                                                                          Trans(Eol(),            ParserState.state_(ParserStates.END_TOKEN),          setTokenV1()),
                                                                          Trans(DetectToken(),    ParserState.state_(ParserStates.END_TOKEN),          setTokenV1()),
                                                                          Trans(ValidChar(),      ParserState.state_(ParserStates.END_TOKEN),          setTokenV2()),
                                                                          Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                          Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),    onInit())
                                                                        ]);

    states_[ParserState.state_(ParserStates.END_TOKEN)]       = State([ Trans(NextChar(),       ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     getNextChar()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.ERROR)]           = State([ Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.STOP)]            = State([ Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    return ParserStates.values[state].name;
  }

  @override
  void publishEvent(Event event) {
    print ("publishEvent->$event");
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }

  @override
  void setFilter() {
    // TODO: implement setFilter
  }

}
