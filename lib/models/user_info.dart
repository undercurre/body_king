class UserInfo {
  final String username;
  final double weight; // in kg
  final double height; // in cm
  final int age;
  final String gender; // "male" or "female"

  UserInfo({
    required this.username,
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'weight': weight,
    'height': height,
    'age': age,
    'gender': gender,
  };

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      username: json['username'],
      weight: json['weight'],
      height: json['height'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
