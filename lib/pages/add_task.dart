import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              focusNode.requestFocus();
            },
            child: const Icon(Icons.close, color: Colors.black),),
        title: const Text('New Tasks', style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 8.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('What tasks are you planning to perform ?', style: TextStyle(fontSize: 16.0)),
           TextField(
             controller: controller,
              focusNode: focusNode,
              cursorColor: Colors.black,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
          ),
          const SizedBox(height: 50),
          const Divider(),
          const SizedBox(height: 10.0),
          Flexible(
              child: Row(
                children: const [
                  Icon(Icons.work), 
                  SizedBox(width: 15),
                  Text('Work')
                ],
              ),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
          Flexible(
              child: Row(
                children: const [
                  Icon(Icons.calendar_month),
                  SizedBox(width: 15),
                  Text('Today'),
                ],
              ),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
                ]
              ),
            ),
          ),
          Hero(
            tag: 'new_task',
            child: SizedBox(
              width: double.infinity,
              height: 58.0,
              child: ElevatedButton(
                onPressed: () {              
                  Navigator.of(context).pop(controller.text);
                  focusNode.requestFocus();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
