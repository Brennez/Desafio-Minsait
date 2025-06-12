// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:git_app/app/data/datasources/local_datasource/interfaces/interfaces_export.dart';
import 'package:git_app/app/data/models/historic_model.dart';
import 'package:git_app/app/domain/repositories/interfaces/interfaces_export.dart';

class HistoricRepositoryImpl implements HistoricRepository {
  final LocalHistoricDatasource localHistoric;

  HistoricRepositoryImpl({
    required this.localHistoric,
  });

  @override
  List<HistoricModel> getPastSearchs() {
    try {
      final data = localHistoric.getPastSearchs();
      List<HistoricModel> pastSearchs = [];
      if (data != null) {
        data.forEach(
          (key, value) {
            pastSearchs.add(HistoricModel.fromMap(value));
          },
        );
      }
      return pastSearchs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void saveCurrentSearch(String username, DateTime date, data) {
    try {
      localHistoric.saveCurrentSearch(username, date, data);
    } catch (e) {
      rethrow;
    }
  }
}
