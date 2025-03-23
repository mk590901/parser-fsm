import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/basic_state_machine.dart';
import '../../core/event.dart';
import 'parser_controller.dart';
import 'parser_events.dart';
import 'parser_state_machine.dart';
import 'parser_states.dart';

class ParserBloc extends Bloc<Event, ParserState> {
  BasicStateMachine? _stateMachine;
  ParserController? parserController;

  ParserBloc(this.parserController, ParserState initialState) : super(initialState) {
    _stateMachine = ParserStateMachine(initialState.state().index);
    (_stateMachine as ParserStateMachine).setController(parserController);

    on<Eol>((event, emit) {
      done(event, emit);
    });
    on<InvalidChar>((event, emit) {
      done(event, emit);
    });
    on<InvisibleChar>((event, emit) {
      done(event, emit);
    });
    on<ValidChar>((event, emit) {
      done(event, emit);
    });
    on<KeywordChar>((event, emit) {
      done(event, emit);
    });
    on<DetectToken>((event, emit) {
      done(event, emit);
    });
    on<NextChar>((event, emit) {
      done(event, emit);
    });
    on<Init>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<ParserState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      ParserState nextState = ParserState(ParserStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
