// list_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../parser_state_machine/operators.dart';
import '../parser_state_machine/parser_controller.dart';

// Events
abstract class ListEvent {}

class SelectOptionEvent extends ListEvent {
  final String option;
  SelectOptionEvent(this.option);
}

//class AddItemEvent extends ListEvent {}

class AddItemEvent extends ListEvent {
  final String item; // Добавляем поле для строки
  AddItemEvent(this.item); // Конструктор с обязательным параметром
}

class ClearListEvent extends ListEvent {}
class PerformActionEvent extends ListEvent {}

// States
class ListState {
  final String selectedOption;
  final List<String> items;

  ListState({
    required this.selectedOption,
    required this.items,
  });

  ListState copyWith({
    String? selectedOption,
    List<String>? items,
  }) {
    return ListState(
      selectedOption: selectedOption ?? this.selectedOption,
      items: items ?? this.items,
    );
  }
}

// BLoC
class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListState(selectedOption: 'ZwLight.Brightness >= 50', items: [])) {
    on<SelectOptionEvent>((event, emit) {
      emit(state.copyWith(selectedOption: event.option));
    });

    // on<AddItemEvent>((event, emit) {
    //   final newItems = List<String>.from(state.items)..add('Item ${state.items.length + 1}');
    //   emit(state.copyWith(items: newItems));
    // });

    on<AddItemEvent>((event, emit) {
      final newItems = List<String>.from(state.items)..add(event.item); // Используем переданную строку
      emit(state.copyWith(items: newItems));
    });

    on<ClearListEvent>((event, emit) {
      emit(state.copyWith(items: []));
    });

    on<PerformActionEvent>((event, emit) {

      // final newItems = List<String>.from(state.items);
      // newItems.addAll([
      //   'Action result 1',
      //   'Action result 2',
      // ]);
      // emit(state.copyWith(items: newItems));

      ParserController parserController = ParserController(this, state.selectedOption,
          Operators());
      parserController.parse();


    });
  }
}