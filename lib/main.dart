import 'package:final_exam/blocs/expanse_bloc.dart';
import 'package:final_exam/blocs/expanse_event.dart';
import 'package:final_exam/data/models/expanse_model.dart';
import 'package:final_exam/data/services/expanse_database_service.dart';
import 'package:final_exam/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ExpanseBloc()..add(GetExpansesEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
