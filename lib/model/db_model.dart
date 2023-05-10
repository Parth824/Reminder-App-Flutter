class DbModel {
  int? id;
  String category;
  String endTime;
  String dec;
  String date;

  DbModel(
      {required this.id,
      required this.category,
      required this.endTime,
      required this.dec,
      required this.date});

  factory DbModel.json({required Map data}) {
    return DbModel(
        id: data['id'],
        category: data['category'],
        endTime: data['endTime'],
        dec: data['dec'],
        date: data['date']);
  }
}
