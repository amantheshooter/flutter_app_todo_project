import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<MyTodoModel>> fetchTodo() async {
  final response = await http.get('http://jsonplaceholder.typicode.com/todos');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new MyTodoModel.fromJson(job)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MyTodoModel {
  int userId;
  int id;
  String title;
  bool completed;

  MyTodoModel({this.userId, this.id, this.title, this.completed});

  MyTodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
