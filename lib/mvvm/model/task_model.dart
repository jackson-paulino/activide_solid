class TaskModel {
  final String name;
  final String deadline;

  TaskModel({required this.name, required this.deadline});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        name: json['name'] as String, deadline: json['deadline'] as String);
  }

  TaskModel copyWith({
    String? name,
    String? deadline,
  }) {
    return TaskModel(
      name: name ?? this.name,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['deadline'] = this.deadline;
    return data;
  }
}
