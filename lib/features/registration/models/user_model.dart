class UserModel {
  final int id;
  final String fullName;
  final String mobile;
  final String email;
  final String role;
  final bool active;

  UserModel({
    required this.id,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.role,
    required this.active,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'] ?? "",
      mobile: json['mobile'] ?? "",
      email: json['email'] ?? "",
      role: json['role'] ?? "",
      active: json['active'] ?? false,
    );
  }
}