import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';
import 'package:git_app/app/presentation/controllers/controllers_export.dart';
import 'package:git_app/core/dependecies/dependency_injection.dart';
import 'package:go_router/go_router.dart';

import '../../enums/screen_state_enum.dart';
import 'components/components_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> languages = [
    'Dart',
    'JavaScript',
    'Python',
    'Java',
    'C#',
    'C++',
    'Go',
    'Rust',
    'Swift',
    'TypeScript'
  ];

  final UserInfoController _userInfoController = injector<UserInfoController>();

  final CacheController _cacheController = injector<CacheController>();

  final HistoricController _historicController = injector<HistoricController>();

  final TextEditingController _usernameTextController = TextEditingController();

  String? selectedLanguage;

  bool _showAdvancedOptions = false;

  Future<void> _handleSearch() async {
    final UserModel? cachedUser =
        await _cacheController.getUserCache(_usernameTextController.text);

    if (cachedUser != null) {
      _userInfoController.setUserInfo(cachedUser);
    }

    if (cachedUser == null) {
      await _userInfoController.getUserInfo(_usernameTextController.text);

      if (_userInfoController.userInfo != null) {
        await _cacheController.saveUserCache(_usernameTextController.text,
            _userInfoController.userInfo!.toMap());

        _historicController.saveHistoric(_usernameTextController.text,
            DateTime.now(), _userInfoController.userInfo!.toMap());
      }
    }

    setState(() {});
  }

  Future<void> _handleClearCache() async {
    await _cacheController.clearAllCache();
    _userInfoController.setUserInfo(null);
    _usernameTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Git App'),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF57606A),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color(0xFF24292F)),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Color(0xFF24292F),
              ),
              title: Text('Histórico de buscas'),
              onTap: () {
                context.push('/historic').then((value) {
                  if (value != null) {
                    _usernameTextController.value =
                        TextEditingValue(text: value.toString());
                  }
                });

                context.pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.clear_all,
                color: Color(0xFF24292F),
              ),
              title: Text('Limpar cache'),
              onTap: () async {
                await _handleClearCache();

                setState(() => context.pop(context));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          CustomSearchComponent(
                            textEditingController: _usernameTextController,
                            hintText: "Digite seu username",
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PrimaryButton(
                                  onTap: () => _handleSearch(),
                                  labelText: "Buscar",
                                ),
                                PrimaryButton(
                                  onTap: () {
                                    setState(() {
                                      _showAdvancedOptions =
                                          !_showAdvancedOptions;
                                    });
                                  },
                                  labelText: "Avançado",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: _showAdvancedOptions,
                        child: Column(
                          children: [
                            CustomSearchComponent(
                              textEditingController: TextEditingController(),
                              hintText: "Localização",
                              iconData: Icons.location_on_outlined,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LanguageDropdownComponent(onSelected: (value) {}),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomSliderComponent(
                              title: "Seguidores",
                              onChanged: (value) {},
                            ),
                            CustomSliderComponent(
                              title: "Repositórios",
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  if (_userInfoController.screenState == ScreenState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_userInfoController.userInfo != null) {
                    return UserCardComponent(
                      user: _userInfoController.userInfo!,
                    );
                  } else if (_userInfoController.screenState ==
                      ScreenState.error) {
                    return Center(
                      child: Text(
                        "Erro ao buscar usuário",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "Digite um username para buscar",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
