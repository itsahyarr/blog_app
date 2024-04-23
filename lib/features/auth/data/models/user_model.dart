import '../../../../core/common/entities/user.dart';

// part 'user_model.freezed.dart';
// part 'user_model.g.dart';

// @freezed
// class UserModel extends User with _$UserModel {
//   factory UserModel({
//     required String id,
//     required String? email,
//     required String name,
//   }) = _UserModel;

// factory UserModel.fromJson(Map<String, Object?> json) =>
//     _$UserModelFromJson(json);
// }

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
