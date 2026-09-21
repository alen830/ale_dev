class UserModel {
  final int? id;
  final String name;
  final String email;

  UserModel({this.id, required this.name, required this.email});

  // Konversi dari Map (SQLite) ke Object UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  // Konversi dari Object UserModel ke Map (SQLite)
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }
}
