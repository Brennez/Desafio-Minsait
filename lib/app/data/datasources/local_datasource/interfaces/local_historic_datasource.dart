abstract class LocalHistoricDatasource {
  Map<String, dynamic>? getPastSearchs();

  void saveCurrentSearch(String username, DateTime date, dynamic data);
}
