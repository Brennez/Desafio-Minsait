import 'package:git_app/app/data/models/models_export.dart';

abstract class HistoricRepository {
  List<HistoricModel> getPastSearchs();

  void saveCurrentSearch(String username, DateTime date, dynamic data);
}
