import 'package:bloc/bloc.dart';
import 'package:final_exam/blocs/expanse_event.dart';
import 'package:final_exam/blocs/expanse_state.dart';
import 'package:final_exam/data/models/expanse_model.dart';
import 'package:final_exam/data/services/expanse_database_service.dart';

class ExpanseBloc extends Bloc<ExpanseEvent, ExpanseState> {
  ExpanseBloc() : super(ExpanseInitialState()) {
    on<GetExpansesEvent>(_onGetExpanses);
    on<UpdateExpanseEvent>(_onUpdateExpanse);
    on<AddExpanseEvent>(_onAddExpanse);
    on<DeleteExpanseEvent>(_onDeleteExpanse);
  }

  final expanseService = ExpanseService();

  Future<void> _onGetExpanses(GetExpansesEvent event, emit) async {
    emit(ExpanseLoadingState());
    try {
      final List<ExpanseModel> expanses = await expanseService.getExpanses();
      emit(ExpanseLoadedState(expanses: expanses));
    } catch (error) {
      emit(ExpanseErrorState(error: error.toString()));
    }
  }

  Future<void> _onUpdateExpanse(UpdateExpanseEvent event, emit) async {
    emit(ExpanseLoadingState());
    try {
      await expanseService.updateExpanse(event.id, event.expanse);
      add(GetExpansesEvent());
    } catch (error) {
      emit(ExpanseErrorState(error: error.toString()));
    }
  }

  Future<void> _onDeleteExpanse(DeleteExpanseEvent event, emit) async {
    emit(ExpanseLoadingState());
    try {
      await expanseService.deleteExpanse(event.id);
      add(GetExpansesEvent());
    } catch (error) {
      emit(ExpanseErrorState(error: error.toString()));
    }
  }

  Future<void> _onAddExpanse (AddExpanseEvent event, emit ) async {
     emit(ExpanseLoadingState());
    try {
      await expanseService.addExpanse(event.expanse);
      add(GetExpansesEvent());
    } catch (error) {
      emit(ExpanseErrorState(error: error.toString()));
    }
  }
}
