class TaskResponseModel {
  String? id;
  String? title;
  String? description;
  String? deadline;
  String? lastUpdated;

  TaskResponseModel({
    this.id,
    this.title,
    this.description,
    this.deadline,
    this.lastUpdated,
  });

  TaskResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['deadline'] = this.deadline;
    data['lastUpdated'] = this.lastUpdated;

    return data;
  }
}
