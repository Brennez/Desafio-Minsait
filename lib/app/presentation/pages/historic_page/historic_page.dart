import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';
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
  final UserInfoController _userInfoController = injector<UserInfoController>();

  final List<HistoricModel> _historicSearchs = [];

  @override
  void initState() {
    super.initState();
    _historicController.getHistoricList();
    sortSearchsByDate();
  }

  void sortSearchsByDate() {
    _historicController.historicSearchs.sort((a, b) => b.compareTo(a));
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: _historicController.historicSearchs.map((search) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.alternate_email_sharp,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(search.userModel.username),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(search.dateTime.toString())
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.search,
                            size: 20,
                          ),
                          onTap: () {
                            _userInfoController.setUserInfo(search.userModel);
                            context.pop(search.userModel.username);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ));
  }
}
