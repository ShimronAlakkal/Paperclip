class DatabaseModel {
  static const tableName = 'noteTable';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colDescription = 'description';
  static const colPriority = 'priority';
  static const colDate = 'date';
  static const colDeadline = 'deadline';
  int id;
  String title;
  String description;
  int priority;
  String date;
  String deadline;

  DatabaseModel(
      {this.id,
      this.title,
      this.description,
      this.priority,
      this.date,
      this.deadline});

  DatabaseModel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    title = map[colTitle];
    description = map[colDescription];
    priority = map[colPriority];
    date = map[colDate];
    deadline = map[colDeadline];
  }

  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      colTitle: title,
      colDescription: description,
      colPriority: priority,
      colDate: date,
      colDeadline: deadline,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
