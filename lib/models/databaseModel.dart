class DatabaseModel {
  static const tableName = 'noteTable';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colDescription = 'description';
  static const colPriority = 'priority';
  int id;
  String title;
  String description;
  int priority;

  DatabaseModel({this.id, this.title, this.description, this.priority});

  DatabaseModel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    title = map[colTitle];
    description = map[colDescription];
    priority = map[colPriority];
  }

  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      colTitle: title,
      colDescription: description,
      colPriority: priority
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
