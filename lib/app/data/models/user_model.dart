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

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['login'] as String,
      followers: json['followers'] as int,
      following: json['following'] as int,
      repositories: json['public_repos'] as int,
      email: json['email'] as String?,
      profilePictureUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
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
