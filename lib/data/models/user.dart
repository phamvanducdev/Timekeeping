class User {
  final String userId;
  final String userName;

  const User({
    required this.userId,
    required this.userName,
  });

  factory User.fromMap(Map<String, dynamic> maps) {
    return User(
      userId: maps['userId'] as String,
      userName: maps['userName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
    };
  }
}
