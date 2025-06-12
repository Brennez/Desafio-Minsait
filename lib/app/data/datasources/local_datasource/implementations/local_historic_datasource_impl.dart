import 'package:git_app/app/data/datasources/local_datasource/interfaces/interfaces_export.dart';
import 'package:hive/hive.dart';

class LocalHistoricDatasourceImpl implements LocalHistoricDatasource {
  @override
  Map<String, dynamic>? getPastSearchs() {
    try {
      final Box box = Hive.box('searchs');

      final Map<String, Map<String, dynamic>> allData = {};

      for (var key in box.keys) {
        final value = box.get(key);
        if (value is Map) {
          allData[key.toString()] = Map<String, dynamic>.from(value);
        }
      }

      return allData;
    } catch (e) {
      throw Exception("error on get searchs $e");
    }
  }

  @override
  void saveCurrentSearch(String username, DateTime date, dynamic data) {
    try {
      final Box box = Hive.box('searchs');
      box.put("user_$username", {
        "search_date": date,
        "data": data,
      });
    } catch (e) {
      throw Exception("error on save search $e");
    }
  }
}
