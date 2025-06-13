import 'package:flutter/material.dart';
import 'package:git_app/app/data/models/models_export.dart';

class UserCardComponent extends StatefulWidget {
  final UserModel user;
  const UserCardComponent({
    super.key,
    required this.user,
  });

  @override
  State<UserCardComponent> createState() => _UserCardComponentState();
}

class _UserCardComponentState extends State<UserCardComponent> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ExpansionPanelList(
        elevation: 1,
        animationDuration: const Duration(milliseconds: 300),
        expansionCallback: (int index, bool isExpanded) {
          _toggleExpansion();
        },
        children: [
          ExpansionPanel(
            backgroundColor: Colors.grey.shade100,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.user.profilePictureUrl ??
                      'https://avatars.githubusercontent.com/u/9919?v=4'),
                ),
                title: Text(widget.user.name ?? 'Sem nome'),
                subtitle: Text(widget.user.bio ?? 'Sem biografia'),
                onTap: () => _toggleExpansion(),
              );
            },
            body: Column(
              children: [
                ListTile(
                  title: const Text('Username'),
                  subtitle: Text(widget.user.username ?? "Sem username"),
                  leading: Icon(Icons.alternate_email_rounded,
                      color: Colors.deepPurple),
                ),
                ListTile(
                  title: const Text('Localização'),
                  subtitle: Text(widget.user.location ?? 'Não informado'),
                  leading: Icon(Icons.location_on, color: Colors.red),
                ),
                ListTile(
                  title: const Text('Repositórios'),
                  subtitle: Text(widget.user.repositories.toString()),
                  leading: Icon(Icons.folder, color: Colors.blue),
                ),
                ListTile(
                  title: const Text('Seguidores'),
                  subtitle: Text(widget.user.followers.toString()),
                  leading: Icon(Icons.people, color: Colors.green),
                ),
                ListTile(
                  title: const Text('Seguindo'),
                  subtitle: Text(widget.user.following.toString()),
                  leading: Icon(Icons.person_add, color: Colors.orange),
                ),
              ],
            ),
            isExpanded: _isExpanded,
          ),
        ],
      ),
    );
  }
}
