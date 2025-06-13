import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';
import 'package:git_app/app/presentation/controllers/controllers_export.dart';
import 'package:git_app/core/dependecies/dependency_injection.dart';
import 'package:go_router/go_router.dart';

import '../../enums/enums_export.dart';
import '../../enums/screen_state_enum.dart';
import 'components/components_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserInfoController _userInfoController = injector<UserInfoController>();

  final CacheController _cacheController = injector<CacheController>();

  final HistoricController _historicController = injector<HistoricController>();

  final TextEditingController _usernameTextController = TextEditingController();

  final TextEditingController _locationTextController = TextEditingController();

  String? _selectedLanguage;

  int? _minFollowers;
  int? _minRepos;

  FilterType _filterType = FilterType.none;

  Future<void> _handleSearch() async {
    final UserModel? cachedUser =
        await _cacheController.getUserCache(_usernameTextController.text);

    if (cachedUser != null) {
      _userInfoController.setUserInfo(cachedUser);
      return;
    }

    bool isAdvancedSearch = _filterType != FilterType.none &&
        (_selectedLanguage != null ||
            _locationTextController.text.trim().isNotEmpty ||
            (_minFollowers != null && _minFollowers! > 0) ||
            (_minRepos != null && _minRepos! > 0));

    if (isAdvancedSearch) {
      final query = buildQuery(
        _locationTextController.text.trim(),
        _selectedLanguage,
        _minFollowers,
        _minRepos,
      );

      await _userInfoController.getAdvancedUserInfo(
          _usernameTextController.text, query, _filterType);
    } else {
      await _userInfoController.getUserInfo(_usernameTextController.text);
    }

    if (_userInfoController.userInfo != null) {
      await _cacheController.saveUserCache(
          _usernameTextController.text, _userInfoController.userInfo!.toMap());

      _historicController.saveHistoric(_usernameTextController.text,
          DateTime.now(), _userInfoController.userInfo!.toMap());
    }

    setState(() {});
  }

  Future<void> _handleClearCache() async {
    await _cacheController.clearAllCache();
    _userInfoController.setUserInfo(null);
    _usernameTextController.clear();
  }

  void clearAllFields() {
    _selectedLanguage == null;
    _locationTextController.text = "";
    _minFollowers = 0;
    _selectedLanguage = null;
    _minRepos = 0;
  }

  String buildQuery(
      String? location, String? language, int? minFollowers, int? minRepos) {
    String query = '';
    if (location != null && location.isNotEmpty) {
      query += 'location:$location+';
    }
    if (language != null && language.isNotEmpty) {
      query += 'language:$language+';
    }
    if (minFollowers != null) {
      query += 'followers:>$minFollowers+';
    }
    if (minRepos != null) {
      query += 'repos:>$minRepos+';
    }
    query = query.trim().replaceAll(' ', '+');
    if (query.endsWith('+')) query = query.substring(0, query.length - 1);

    return query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Git App'),
        centerTitle: true,
      ),
      endDrawer: DrawerComponnent(
        onTapHome: () => context.pop(),
        onTapHistoric: () {
          context.push('/historic').then((value) {
            if (value != null) {
              _usernameTextController.value =
                  TextEditingValue(text: value.toString());
            }
          });

          context.pop();
        },
        onTapClearCache: () async {
          await _handleClearCache();

          setState(() => context.pop(context));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: Card(
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
                            FilterTypeSelector(onChanged: (value) {
                              setState(() {
                                _filterType = value;
                                clearAllFields();
                              });
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _filterType == FilterType.location,
                          child: CustomSearchComponent(
                            textEditingController: _locationTextController,
                            hintText: "Localização",
                            iconData: Icons.location_on_outlined,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _filterType == FilterType.language,
                          child: LanguageDropdownComponent(onSelected: (value) {
                            _selectedLanguage = value;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _filterType == FilterType.followers,
                          child: CustomSliderComponent(
                            title: "Seguidores",
                            onChanged: (value) {
                              _minFollowers = value;
                            },
                          ),
                        ),
                        Visibility(
                          visible: _filterType == FilterType.repos,
                          child: CustomSliderComponent(
                            title: "Repositórios",
                            onChanged: (value) {
                              _minRepos = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onTap: () => _handleSearch(),
                                labelText: "Buscar",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                        "Usuário não encontrado",
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
