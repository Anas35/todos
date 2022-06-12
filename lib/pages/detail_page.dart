import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todos/models/task.dart';
import 'package:todos/models/todo_type.dart';
import 'package:todos/pages/add_task.dart';
import 'package:todos/widgets/avatar.dart';

class DetailPage extends StatefulWidget {
  final TodoType todoType;

  const DetailPage({Key? key, required this.todoType}) : super(key: key);

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
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.grey.shade700),
            actions: [
              Icon(Icons.more_vert, color: Colors.grey.shade700),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'new_task',
            child: const Icon(Icons.add),
            onPressed: () async {
              final String? value = await Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(seconds: 1),
                  reverseTransitionDuration: const Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => const MyButton(),
                ),
              );
                  
                if (value != null && value.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(value));
                  });
                }
            },
          ),
          body: Hero(
          tag: widget.todoType.title,
          child: Material(
            child:  Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    CustomAvator(
                      child: Icon(widget.todoType.icon, color: widget.todoType.color),
                    ),
                    
                    const SizedBox(height: 20),
                    Text(
                      '${widget.todoType.tasks} Tasks',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.todoType.title,
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearProgressIndicator(
                            value: 0.83,
                            backgroundColor: Colors.grey.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(widget.todoType.color),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text("83%",
                                style: TextStyle(fontSize: 10, color: Colors.black)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: AnimatedList(
                        initialItemCount: tasks.length + 1,
                        itemBuilder: (context, i, animation) {
                          if(i == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text('Today', style: TextStyle(fontSize: 18, color: Colors.grey.shade700),),
                            );
                          }
                          Task task = tasks[--i];
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
                                    child: const Icon(Icons.delete,
                                        color: Colors.black),
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
            ),
          ),
    );
  }
}
