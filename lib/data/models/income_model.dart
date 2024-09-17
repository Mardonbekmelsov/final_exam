class IncomeModel {
  double value;
  String category;
  DateTime time;
  String comment;

  IncomeModel({
    required this.value,
    required this.category,
    required this.time,
    required this.comment,
  });

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      value: map['value'],
      category: map['category'],
      time: map['time'],
      comment: map['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'category': category,
      'time': time,
      'comment': comment,
    };
  }
}
