// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;

  final String email;
  final String uid;
  final String profilePic;
  final String bannerPic;
  final String bio;
  final List<String> followers;
  final List<String> following;
  final bool isTwitterBlue;
  const UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePic,
    required this.bannerPic,
    required this.bio,
    required this.followers,
    required this.following,
    required this.isTwitterBlue,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? profilePic,
    String? bannerPic,
    String? bio,
    List<String>? followers,
    List<String>? following,
    bool? isTwitterBlue,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      bannerPic: bannerPic ?? this.bannerPic,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'bannerPic': bannerPic,
      'bio': bio,
      'followers': followers,
      'following': following,
      'isTwitterBlue': isTwitterBlue,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['\$id'] as String,
      profilePic: map['profilePic'] as String,
      bannerPic: map['bannerPic'] as String,
      bio: map['bio'] as String,
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      isTwitterBlue: map['isTwitterBlue'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, uid: $uid, profilePic: $profilePic, bannerPic: $bannerPic, bio: $bio, followers: $followers, following: $following, isTwitterBlue: $isTwitterBlue)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.bannerPic == bannerPic &&
        other.bio == bio &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.isTwitterBlue == isTwitterBlue;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        bannerPic.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        isTwitterBlue.hashCode;
  }
}
