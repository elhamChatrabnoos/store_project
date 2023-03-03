import 'package:shop_getx/repositories/dio_field.dart';

import '../models/user.dart';

class UserRepository{

  Future<User> addUser({required User newUser}) async{
    try{
      var response = await dioBaseUrl.post('user', data: newUser.toJson());
      User retrievedUser = User.fromJson(response.data);
      return retrievedUser;
    }
    catch(e){
      print('add user errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<List<User>>getUsers() async{
    var response = await dioBaseUrl.get('user');
    try {
      final userResult = await response.data.map<User>((element) {
        return User.fromJson(element);
      }).toList();
      return userResult;
    } catch (e) {
      print('****get user error*****: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<User> editUser({required User targetUser, required num userId}) async{
    try{
      var response = await dioBaseUrl.put('user/${userId.toString()}', data: targetUser.toJson());
      User retrievedUser = User.fromJson(response.data);
      return retrievedUser;
    }
    catch(e){
      print('***edit user error*** ${e.toString()}');
      return throw e.toString();
    }
  }


}