import 'dart:convert';

class Note {
  int? id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateEdited;

  Note(
      {this.id,
      required this.title,
      required this.content,
      required this.dateCreated,
      required this.dateEdited});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'dateCreated': epochFromDate(dateCreated),
      'dateEdited': epochFromDate(dateEdited)
    };

    return data;
  }

  factory Note.fromMap(int id, Map<String, dynamic> map) {
    return Note(
        id: id,
        title: utf8.decode(map['title']),
        content: utf8.decode(map['content']),
        dateCreated: dateFromEpoch(map['dateCreated']),
        dateEdited: dateFromEpoch(map['dateEdited']));
  }

  static int epochFromDate(DateTime dt) => dt.millisecondsSinceEpoch ~/ 1000;
  static DateTime dateFromEpoch(int epoch) =>
      DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
}
