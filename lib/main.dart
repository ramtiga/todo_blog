import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                actionExtentRatio: 0.2,
                actionPane: SlidableScrollActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Archive',
                    color: Colors.lightBlue,
                    icon: Icons.archive,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    caption: 'share',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap: () {},
                  ),
                ],
                secondaryActions: [
                  IconSlideAction(
                    caption: 'More',
                    color: Colors.black45,
                    icon: Icons.more_horiz,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      todo.deleteTodo(index);
                    },
                  ),
                ],
                child: Container(
                  decoration: BoxDecoration(color: Colors.deepOrange[400]),
                  child: ListTile(
                    leading: Icon(
                      todoList[index].getIcon,
                      color: Colors.white,
                    ),
                    title: Text(todoList[index].getTitle,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo with ChangeNotifier {
  void deleteTodo(int index) {
    todoList.removeAt(index);
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
