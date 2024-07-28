import 'package:sqlite3/sqlite3.dart';

class Task {
  int? id;
  String? title;
  DateTime? startDateTime;
  DateTime? endDateTime;

  Task({
    this.endDateTime,
    this.id,
    this.startDateTime,
    this.title,
  });

  factory Task.fromRow(Row row) {
    return Task(
      endDateTime: DateTime.fromMillisecondsSinceEpoch(row['endDateTime']),
      startDateTime: DateTime.fromMillisecondsSinceEpoch(row['startDateTime']),
      title: row['title'],
      id: row['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startDateTime': startDateTime?.millisecondsSinceEpoch,
      'endDateTime': endDateTime?.millisecondsSinceEpoch,
    };
  }
}
