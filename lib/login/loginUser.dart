class LoginUser {
  final String username;
  final List<String> roleIdList;
  final List<String> companyIdList;
  final String jwt;
  final String organize;

  LoginUser({
    required this.username,
    required this.roleIdList,
    required this.companyIdList,
    required this.jwt,
    required this.organize,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      username: json['username'],
      roleIdList: List<String>.from(json['roleIdList']),
      companyIdList: List<String>.from(json['companyIdList']),
      jwt: json['jwt'],
      organize: json['organize'],
    );
  }

  toJson() {
    return {
      'username': username,
      'roleIdList': roleIdList,
      'companyIdList': companyIdList,
      'jwt': jwt,
      'organize': organize,
    };
  }
}
