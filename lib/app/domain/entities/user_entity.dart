class UserEntity {
  final int? id;
  final String? name;
  final String? username;
  final String? bio;
  final String? location;
  final int? followers;
  final int? following;
  final int? repositories;
  final String? email;
  final String? profilePictureUrl;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    this.bio,
    this.location,
    required this.followers,
    required this.following,
    required this.repositories,
    this.email,
    this.profilePictureUrl,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, username: $username, bio: $bio, location: $location, followers: $followers, following: $following, repositories: $repositories, email: $email, profilePictureUrl: $profilePictureUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.bio == bio &&
        other.location == location &&
        other.followers == followers &&
        other.following == following &&
        other.repositories == repositories &&
        other.email == email &&
        other.profilePictureUrl == profilePictureUrl;
  }
}
