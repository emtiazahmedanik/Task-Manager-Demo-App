import '../services/auth_service.dart';

class User{
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone
});

}
class CallApi{
  Future<List<User>> callApi() async{
    final data = await getProfileDetail();
    final transformed = data.map((user){
      return User(
          email: user["email"],
          firstName: user["firstName"],
          lastName: user["lastName"],
          phone: user["mobile"]
      );
    }).toList();
    return transformed;
  }
}