import 'package:equatable/equatable.dart';
class User extends Equatable {
  final String message;
  final bool result;
  final String name;
  final String email;
  final String? email_verified_at;
  final String? google_id;
  final int active_organisation;
  final String? profile_photo;
  final String updated_at;
  final String created_at;
  final int id;

  // Добавляем const конструктор
  const User({
    required this.message,
    required this.result,
    required this.name,
    required this.email,
    this.email_verified_at,
    this.google_id,
    required this.active_organisation,
    this.profile_photo,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final user = data['user'];
    return User(
      message: json['message'],
      result: data['result'],
      name: user['name'],
      email: user['email'],
      email_verified_at: user['email_verified_at'],
      google_id: user['google_id'],
      active_organisation: user['active_organisation'],
      profile_photo: user['profile_photo'],
      updated_at: user['updated_at'],
      created_at: user['created_at'],
      id: user['id'],
    );
  }

  static const User empty = User(
    message: '',
    result: false,
    name: '',
    email: '',
    email_verified_at: null,
    google_id: null,
    active_organisation: 0,
    profile_photo: null,
    updated_at: '',
    created_at: '',
    id: 0,
  );

  @override
  List<Object?> get props => [
    message,
    result,
    name,
    email,
    email_verified_at,
    google_id,
    active_organisation,
    profile_photo,
    updated_at,
    created_at,
    id,
  ];

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'result': result,
        'user': {
          'name': name,
          'email': email,
          'email_verified_at': email_verified_at,
          'google_id': google_id,
          'active_organisation': active_organisation,
          'profile_photo': profile_photo,
          'updated_at': updated_at,
          'created_at': created_at,
          'id': id,
        }
      }
    };
  }
}

