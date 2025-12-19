import 'package:exam_2_pareja/dominio/models/user.dart';

abstract class UseCases {
  Future<List> getAllUsers();
  Future<bool> addUser(String username, String password);
  Future<bool> modifyUser(User userdata);
  Future<bool> deleteUser(String userId);
  Future<bool> loginUser(String username, String password);
}