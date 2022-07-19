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
        title: utf8.decode([...map['title']]),
        content: utf8.decode([...map['content']]),
        dateCreated: dateFromEpoch(map['dateCreated']),
        dateEdited: dateFromEpoch(map['dateEdited']));
  }

  static int epochFromDate(DateTime dt) => dt.millisecondsSinceEpoch ~/ 1000;
  static DateTime dateFromEpoch(int epoch) =>
      DateTime.fromMillisecondsSinceEpoch(epoch * 1000);

  static String timeAgo(DateTime dateTime) {
    var now = DateTime.now();
    var difference = now.difference(dateTime);
    var seconds = difference.inSeconds;
    var minutes = difference.inMinutes;
    var hours = difference.inHours;
    var days = difference.inDays;
    var months = difference.inDays / 30;
    var years = difference.inDays / 365;
    if (seconds < 45) {
      return 'a few seconds ago';
    } else if (seconds < 90) {
      return 'a minute ago';
    } else if (minutes < 45) {
      return '$minutes minutes ago';
    } else if (minutes < 90) {
      return 'an hour ago';
    } else if (hours < 24) {
      return '$hours hours ago';
    } else if (hours < 48) {
      return 'a day ago';
    } else if (days < 30) {
      return '$days days ago';
    } else if (days < 60) {
      return 'a month ago';
    } else if (days < 365) {
      return '$months months ago';
    } else if (days < 730) {
      return 'a year ago';
    } else {
      return '$years years ago';
    }
  }
}
