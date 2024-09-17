import 'package:final_exam/data/models/expanse_model.dart';

sealed class ExpanseEvent {}

class GetExpansesEvent extends ExpanseEvent {}

class AddExpanseEvent extends ExpanseEvent {
  ExpanseModel expanse;

  AddExpanseEvent({required this.expanse});
}

class UpdateExpanseEvent extends ExpanseEvent {
  ExpanseModel expanse;
  int id;

  UpdateExpanseEvent({
    required this.expanse,
    required this.id,
  });
}

class DeleteExpanseEvent extends ExpanseEvent {
  int id;

  DeleteExpanseEvent({required this.id});
}
