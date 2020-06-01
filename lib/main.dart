import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterappsecondproject/models/TodoModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  // This widget is the root of your application.

  Future<List<MyTodoModel>> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.blue.shade700,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<MyTodoModel>>(
        future: fetchTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MyTodoModel> data = snapshot.data;
            return _jobsListView(data);
          } else if (snapshot.hasError) {
            return Center(child: Column(
              children: <Widget>[
                Text('Connection Error!'),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {

                  },
                  child: Text(
                    "Retry",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].title, data[index].title, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
