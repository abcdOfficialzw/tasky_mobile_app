class Task {
  final int? id;
  final String? uuid;
  final String title;
  final String description;
  final DateTime deadline;
  final bool isSynced;
  final DateTime lastModified;
  final bool deleted;

  Task({
    this.id,
    this.uuid,
    required this.title,
    required this.description,
    required this.deadline,
    required this.lastModified,
    this.isSynced = false,
    this.deleted = false,
  });

  Task copy(
      {int? id,
      String? uuid,
      String? title,
      String? description,
      DateTime? deadline,
      bool? isSynced,
      DateTime? lastModified,
      bool deleted = false}) {
    return Task(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isSynced: isSynced ?? this.isSynced,
      lastModified: lastModified ?? this.lastModified,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'isSynced': isSynced ? 1 : 0,
      'lastModified': lastModified.toIso8601String(),
      'deleted': deleted ? 1 : 0,
    };
  }

  // define fromJson method
  factory Task.fromJson(Map<String, Object?> json) {
    return Task(
      id: json['id'] as int,
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      isSynced: json['isSynced'] == 1 ? true : false,
      lastModified: DateTime.parse(json['lastModified'] as String),
      deleted: json['deleted'] == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, uuid: $uuid ,title: $title, description: $description, deadline: $deadline, isSynced: $isSynced, lastModified: $lastModified}, deleted: $deleted';
  }
}
