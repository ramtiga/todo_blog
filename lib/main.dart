import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoProvider = ChangeNotifierProvider((ref) => Todo());

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = useProvider(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST App"),
      ),
      body: Container(
        child: ReorderableListView(
          children: todoList.map((TodoModel todoModel) {
            return Container(
              key: Key(todoModel.getKey),
              decoration: BoxDecoration(color: Colors.deepOrange[400]),
              child: ListTile(
                leading: Icon(
                  todoModel.icon,
                  color: Colors.white,
                ),
                title: Text(
                  todoModel.getTitle,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            todo.dragAndDrop(oldIndex, newIndex);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo with ChangeNotifier {
  void dragAndDrop(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    TodoModel todoModel = todoList.removeAt(oldIndex);

    todoList.insert(newIndex, todoModel);
    notifyListeners();
  }
}

class TodoModel {
  String title;
  IconData icon;
  String key;

  TodoModel({this.title, this.icon, this.key});

  String get getTitle => title;
  IconData get getIcon => icon;
  String get getKey => key;
}

List<TodoModel> todoList = [
  TodoModel(
    title: "英単語の勉強",
    icon: Icons.event_note,
    key: "1",
  ),
  TodoModel(
    title: "ブログ記事作成",
    icon: Icons.edit,
    key: "2",
  ),
  TodoModel(
    title: "筋トレ",
    icon: Icons.accessibility,
    key: "3",
  ),
];
