import 'package:final_exam/blocs/expanse_bloc.dart';
import 'package:final_exam/blocs/expanse_event.dart';
import 'package:final_exam/blocs/expanse_state.dart';
import 'package:final_exam/data/models/expanse_model.dart';
import 'package:final_exam/ui/widgets/add_dialog.dart';
import 'package:final_exam/ui/widgets/edit_expanse_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  double getPercent(List<ExpanseModel> expanses, String category) {
    // double percent = 0;
    double categorySum = 0;
    double sum = 0;
    expanses.forEach((element) {
      sum += element.value;
      if (element.category == category) {
        categorySum += element.value;
      }
    });
    return categorySum / sum * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Expanses")),
      body: BlocBuilder<ExpanseBloc, ExpanseState>(
        builder: (context, state) {
          if (state is ExpanseLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExpanseErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is ExpanseLoadedState) {
            final expanses = state.expanses;

            if (expanses.isEmpty) {
              return const Center(
                child: Text(
                  "Xarajatlar Yo'q",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 380,
                    child: ListView.builder(
                      itemCount: expanses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              "-\$${expanses[index].value} ${expanses[index].comment}"),
                          subtitle: Text(
                            "${expanses[index].time.day}.${expanses[index].time.month}.${expanses[index].time.year}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EditExpanseDialog(
                                          expanse: expanses[index]);
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<ExpanseBloc>().add(
                                      DeleteExpanseEvent(
                                          id: expanses[index].id));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 100,
                                width: 70,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Oziq ovqat")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          return const Center(
            child: Text("Ma'lumotlar mavjud emas"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddDialog(type: "Expanse");
            },
          );
        },
      ),
    );
  }
}
