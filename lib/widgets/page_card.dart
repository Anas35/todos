import 'package:flutter/material.dart';
import 'package:todos/models/todo_type.dart';
import 'package:todos/pages/detail_page.dart';
import 'package:todos/widgets/avatar.dart';

class PageCard extends StatelessWidget {
  final TodoType todoType;

  const PageCard({
    Key? key,
    required this.todoType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < 0) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 750),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => DetailPage(todoType: todoType),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 0.0),
        child: Hero(
          tag: todoType.title,
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomAvator(
                          child: Icon(todoType.icon, color: todoType.color),
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                      ]),
                  const Spacer(),
                  Text('${todoType.tasks} Tasks',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(
                    todoType.title,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: LinearProgressIndicator(
                          value: 0.83,
                          backgroundColor: Colors.grey.withAlpha(50),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(todoType.color),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("83%",
                            style:
                                TextStyle(fontSize: 10, color: Colors.black)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
