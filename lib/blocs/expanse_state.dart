import 'package:final_exam/data/models/expanse_model.dart';

sealed class ExpanseState {}

class ExpanseInitialState extends ExpanseState {}

class ExpanseLoadingState extends ExpanseState {}

class ExpanseLoadedState extends ExpanseState {
  List<ExpanseModel> expanses;

  ExpanseLoadedState({required this.expanses});
}

class ExpanseErrorState extends ExpanseState {
  String error;

  ExpanseErrorState({required this.error});
}
