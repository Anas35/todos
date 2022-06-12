import 'package:flutter/material.dart';
import 'package:todos/models/todo_type.dart';
import 'package:todos/widgets/page_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LinearGradient> colors = const [
    LinearGradient(colors: [
      Color(0xFFF54471),
      Color(0xFFF5a151),
    ]),
    LinearGradient(colors: [
      Color(0xFF4d55e1),
      Color(0xFF5da7e7),
    ]),
    LinearGradient(colors: [
      Color(0xFF3dbc9c),
      Color(0xFF3dd484),
    ]),
  ];

  late LinearGradient backgroundColor;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.75);
    backgroundColor = colors[0];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<TodoType> todoTypes = const [
    TodoType(
      title: 'Personal',
      tasks: 9,
      icon: Icons.person,
      color: Color(0xFFF54471),
    ),
    TodoType(
      title: 'Work',
      tasks: 12,
      icon: Icons.work,
      color: Color(0xFF4d55e1),
    ),
    TodoType(
      title: 'Home',
      tasks: 6,
      icon: Icons.home,
      color: Color(0xFF3dbc9c),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.menu),
          title: const Text('TODO'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: FlutterLogo(),
                    ),
                    SizedBox(height: 20),
                    Text('Hello, Jane.', style: TextStyle(fontSize: 32)),
                    SizedBox(height: 10),
                    Text('Looks like feels good'),
                    Text('You have three task todays'),
                    SizedBox(height: 30),
                    Text('Today: September 12 2007'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: PageController(
                  viewportFraction: 0.8,
                ),
                padEnds: false,
                onPageChanged: (int? index) {
                  setState(() {
                    backgroundColor = colors[index ?? 0];
                  });
                },
                children: todoTypes.map((TodoType todoType) => PageCard(todoType: todoType)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
