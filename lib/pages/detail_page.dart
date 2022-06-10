import 'package:flutter/material.dart';
import 'package:todos/models/task.dart';
import 'package:todos/pages/add_task.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Task> tasks = [
    Task('Meet Clients'),
    Task('Design Spirit'),
    Task('Icon Set Design for Mobile App'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'hero',
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Icon(Icons.more_vert, color: Colors.grey.shade700),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'new_task',
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(seconds: 1),
                  reverseTransitionDuration: const Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => const MyButton(),
                ),
              ).then((value) {
                if(value != null && value is String && value.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(value));
                  });
                  //AnimatedList.of(context).insertItem(0, duration: const Duration(milliseconds: 500));
                }
              });
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: AnimatedList(
                  initialItemCount: tasks.length,
                  itemBuilder: (context, i, animation) {
                    Task task = tasks[i];
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        task.description,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      value: task.completed,
                      onChanged: task.completed
                          ? null
                          : (bool? value) {
                              setState(() {
                                task.completed = true;
                              });
                            },
                      secondary: task.completed
                          ? InkWell(
                              child:
                                  const Icon(Icons.delete, color: Colors.black),
                              onTap: () {
                                setState(() => tasks.remove(task));
                                AnimatedList.of(context).removeItem(
                                  i,
                                  (context, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(
                                          task.description,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        value: task.completed,
                                        onChanged: null,
                                        secondary: const Icon(Icons.delete),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
