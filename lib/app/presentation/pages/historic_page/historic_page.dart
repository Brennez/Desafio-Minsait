import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_app/app/presentation/controllers/controllers_export.dart';
import 'package:git_app/core/dependecies/dependency_injection.dart';
import 'package:go_router/go_router.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final HistoricController _historicController = injector<HistoricController>();

  @override
  void initState() {
    super.initState();
    _historicController.getHistoricList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Histórico de busca"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: Obx(
          () {
            if (_historicController.historicSearchs.isEmpty) {
              return Center(
                child: Text("Seu histórico está vazio"),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: _historicController.historicSearchs.map((element) {
                  return Container(
                    child: Text(element.userModel.username),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
