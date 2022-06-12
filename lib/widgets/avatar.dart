import 'package:flutter/material.dart';

class CustomAvator extends StatelessWidget {
  final Widget? child;

  const CustomAvator({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 21.0,
      backgroundColor: Colors.grey.shade700,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: child,
      ),
    );
  }
}
