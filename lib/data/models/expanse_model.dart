class ExpanseModel {
  int id;
  double value;
  String category;
  DateTime time;
  String comment;

  ExpanseModel({
    required this.id,
    required this.value,
    required this.category,
    required this.time,
    required this.comment,
  });

  factory ExpanseModel.fromMap(Map<String, dynamic> map) {
    return ExpanseModel(
      id: map['id'],
      value: double.parse(map['value']),
      category: map['category'],
      time: DateTime.parse(map['time']),
      comment: map['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value.toString(),
      'category': category,
      'time': time.toString(),
      'comment': comment,
    };
  }
}
