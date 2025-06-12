import 'package:git_app/app/data/models/models_export.dart';

class HistoricModel {
  DateTime dateTime;
  UserModel userModel;

  HistoricModel({
    required this.dateTime,
    required this.userModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'userModel': userModel.toMap(),
    };
  }

  factory HistoricModel.fromMap(Map<String, dynamic> map) {
    return HistoricModel(
      dateTime: map["search_date"],
      userModel: UserModel.fromMap(Map<String, dynamic>.from(map['data'])),
    );
  }

  int compareTo(HistoricModel other) {
    return dateTime.compareTo(other.dateTime);
  }
}
