import '../../core/basic_state_machine.dart';
import '../../core/event.dart';
import '../../core/state.dart';
import '../../core/trans.dart';
import 'parser_trans_methods.dart';
import 'parser_events.dart';
import 'parser_states.dart';

/*
    private void create()
    {
        states.put(State.State_IDLE,            new StateEntity  (  new TransitionSM(ParserController.Event.NextChar,       State.State_WAIT_NEXT_CHAR,     getNextChar),
                                                                    new TransitionSM(ParserController.Event.Init,           State.State_IDLE,               init))
        );

        states.put(State.State_WAIT_NEXT_CHAR,  new StateEntity  (  new TransitionSM(ParserController.Event.InvisibleChar,  State.State_WAIT_NEXT_CHAR,     getNextChar),
                                                                    new TransitionSM(ParserController.Event.InvalidChar,    State.State_ERROR,              setError),
                                                                    new TransitionSM(ParserController.Event.Eol,            State.State_STOP,               stop),
                                                                    new TransitionSM(ParserController.Event.ValidChar,      State.State_ACCUMULATE_TOKEN,   initToken),
                                                                    new TransitionSM(ParserController.Event.KeywordChar,    State.State_ACCUMULATE_KEYWORD, initToken),
                                                                    new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
                );

        states.put(State.State_ACCUMULATE_TOKEN,new StateEntity  (  new TransitionSM(ParserController.Event.InvisibleChar,  State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.KeywordChar,    State.State_END_TOKEN,          setToken2),
                                                                    new TransitionSM(ParserController.Event.Eol,            State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.DetectToken,    State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.ValidChar,      State.State_ACCUMULATE_TOKEN,   accumulateToken),
                                                                    new TransitionSM(ParserController.Event.InvalidChar,    State.State_ERROR,              setError),
                                                                    new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
                );

        states.put(State.State_ACCUMULATE_KEYWORD,new StateEntity(  new TransitionSM(ParserController.Event.InvisibleChar,  State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.KeywordChar,    State.State_ACCUMULATE_KEYWORD, accumulateToken),
                                                                    new TransitionSM(ParserController.Event.Eol,            State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.DetectToken,    State.State_END_TOKEN,          setToken),
                                                                    new TransitionSM(ParserController.Event.ValidChar,      State.State_END_TOKEN,          setToken2),
                                                                    new TransitionSM(ParserController.Event.InvalidChar,    State.State_ERROR,              setError),
                                                                    new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
        );

        states.put(State.State_END_TOKEN,       new StateEntity  (  new TransitionSM(ParserController.Event.NextChar,       State.State_WAIT_NEXT_CHAR,     getNextChar),
                                                                    new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
                );

        states.put(State.State_ERROR,           new StateEntity  (  new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
                );

        states.put(State.State_STOP,            new StateEntity  (  new TransitionSM(ParserController.Event.Init,           State.State_WAIT_NEXT_CHAR,     init))
                );

    }

 */

class ParserStateMachine extends BasicStateMachine {
  ParserStateMachine(super.currentState);

  @override
  void create() {

    states_ [ParserState.state_(ParserStates.IDLE)]           = State([ Trans(NextChar(),       ParserState.state_(ParserStates.WAIT_NEXT_CHAR),  getNextChar()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.IDLE),  onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.WAIT_NEXT_CHAR)]  = State([ Trans(InvisibleChar(),  ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     getNextChar()),
                                                                        Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                        Trans(Eol(),            ParserState.state_(ParserStates.STOP),               stop()),
                                                                        Trans(ValidChar(),      ParserState.state_(ParserStates.ACCUMULATE_TOKEN),   initToken()),
                                                                        Trans(KeywordChar(),    ParserState.state_(ParserStates.ACCUMULATE_KEYWORD), initToken()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.ACCUMULATE_TOKEN)]= State([ Trans(InvisibleChar(),  ParserState.state_(ParserStates.END_TOKEN),          setToken()),
                                                                        Trans(KeywordChar(),    ParserState.state_(ParserStates.END_TOKEN),          setToken2()),
                                                                        Trans(Eol(),            ParserState.state_(ParserStates.END_TOKEN),          setToken()),
                                                                        Trans(DetectToken(),    ParserState.state_(ParserStates.END_TOKEN),          setToken()),
                                                                        Trans(ValidChar(),      ParserState.state_(ParserStates.ACCUMULATE_TOKEN),   accumulateToken()),
                                                                        Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                        Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR),     onInit()),
                                                                      ]);

    states_[ParserState.state_(ParserStates.ACCUMULATE_KEYWORD)] = State([Trans(InvisibleChar(),  ParserState.state_(ParserStates.END_TOKEN),        setToken()),
                                                                          Trans(KeywordChar(),    ParserState.state_(ParserStates.ACCUMULATE_KEYWORD), accumulateToken()),
                                                                          Trans(Eol(),            ParserState.state_(ParserStates.END_TOKEN),          setToken()),
                                                                          Trans(DetectToken(),    ParserState.state_(ParserStates.END_TOKEN),          setToken()),
                                                                          Trans(ValidChar(),      ParserState.state_(ParserStates.END_TOKEN),          setToken2()),
                                                                          Trans(InvalidChar(),    ParserState.state_(ParserStates.ERROR),              setError()),
                                                                          Trans(Init(),           ParserState.state_(ParserStates.WAIT_NEXT_CHAR), onInit())
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
