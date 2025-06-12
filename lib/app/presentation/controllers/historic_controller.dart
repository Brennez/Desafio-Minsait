// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';

import 'package:git_app/app/domain/repositories/interfaces/interfaces_export.dart';

class HistoricController extends GetxController {
  final HistoricRepository historicRepository;

  HistoricController({
    required this.historicRepository,
  });

  var historicSearchs = <HistoricModel>[].obs;

  void getHistoricList() {
    try {
      final result = historicRepository.getPastSearchs();
      historicSearchs.assignAll(result);
    } catch (e) {
      rethrow;
    }
  }

  void saveHistoric(String username, DateTime date, dynamic data) {
    try {
      historicRepository.saveCurrentSearch(username, date, data);
    } catch (e) {
      rethrow;
    }
  }
}
