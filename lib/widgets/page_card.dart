import 'package:flutter/material.dart';
import 'package:todos/pages/detail_page.dart';

class PageCard extends StatelessWidget {

  final Color color;

  const PageCard({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < 0) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              pageBuilder: (_, __, ___) => const DetailPage()
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 0.0),
        child: Hero(
          tag: 'hero',
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ]),
                const Spacer(),
                const Text('9 Tasks', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text('Personal',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: LinearProgressIndicator(
                        value: 0.83,
                        backgroundColor: Colors.grey.withAlpha(50),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text("83%", style: TextStyle(fontSize: 10, color: Colors.black)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
