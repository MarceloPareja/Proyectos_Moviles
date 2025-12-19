import 'package:exam_2_pareja/dominio/models/user.dart';

import 'bd_repository.dart';
import '../dominio/useCases/use_cases.dart';
class RepositoryImpl extends UseCases{
  BdRepository repository=BdRepository();
  @override
  Future<bool> addUser(String username, String password) async{
    bool userAdded=false;
    if(await repository.addUser(username, password))
      {
        userAdded=true;
      }
    return userAdded;
  }

  @override
  Future<bool> deleteUser(String userId) async{
    bool deleted=false;
    if(await repository.deleteUser(userId))
    {
    deleted=true;
    }
    return deleted;
  }

  @override
  Future<List> getAllUsers() async{
    return repository.getUsers();
  }

  @override
  Future<bool> loginUser(String username, String password) async {
    bool validated=false;
    if(await repository.login(username, password))
    {
      validated=true;
    }
    return validated;
  }

  @override
  Future<bool> modifyUser(User userdata) async{
    bool updated=false;;
    if(await repository.updateUser(userdata))
    {
      updated=true;
    }
    return updated;
  }

}