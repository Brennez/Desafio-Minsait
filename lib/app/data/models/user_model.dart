import 'package:git_app/app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.name,
      required super.username,
      required super.followers,
      required super.following,
      required super.repositories,
      required super.email,
      required super.profilePictureUrl,
      required super.bio,
      required super.location});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      username: map['login'] as String?,
      followers: map['followers'] as int?,
      following: map['following'] as int?,
      repositories: map['public_repos'] as int?,
      email: map['email'] as String?,
      profilePictureUrl: map['avatar_url'] as String?,
      bio: map['bio'] as String?,
      location: map['location'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': username,
      'followers': followers,
      'following': following,
      'public_repos': repositories,
      'email': email,
      'avatar_url': profilePictureUrl,
      'bio': bio,
      'location': location,
    };
  }
}
