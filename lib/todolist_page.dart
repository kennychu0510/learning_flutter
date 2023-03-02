import 'package:flutter/material.dart';

class Todo {
  Todo({required this.task, required this.done});
  final String task;
  bool done;
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var inputController = TextEditingController();
  List<Todo> toDoList = <Todo>[];

  void onAdd() {
    setState(() {
      toDoList.add(Todo(task: inputController.text, done: false));
      inputController.clear();
    });
  }

  void onClear() {
    setState(() {
      toDoList.clear();
    });
  }

  void checkItem(Todo item, bool? value) {
    setState(() {
      var index = toDoList.indexOf(item);
      if (index > -1 && value != null) {
        toDoList[index].done = value;
      }
    });
  }

  void onClearDone() {
    setState(() {
      toDoList = toDoList.where((element) => element.done == false).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Add an item',
                    ),
                    onSubmitted: ((value) => {onAdd()}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: onAdd, child: const Text('Add')),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: toDoList.length,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                final item = toDoList[index];
                return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${(index + 1).toString()}. '),
                      ],
                    ),
                    title: Text(item.task),
                    trailing: Checkbox(
                      value: item.done,
                      onChanged: (value) => {checkItem(item, value)},
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: onClear,
                    child: const Text('Clear All')),
                Spacer(),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: onClearDone,
                    child: const Text('Clear Done')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
