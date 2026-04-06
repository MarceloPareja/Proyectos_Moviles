import '../repositories/profesor_repository.dart';
import '../../domain/entities/profesor.dart';
class ProfesorService {
  ProfesorRepository _repository = ProfesorRepository();

  Future<bool> login (String usuario, String clave)async{
    final data= await _repository.
    for(var item in data){
      if(usuario==item["user"] && clave==item["password"])
        {
          return true;
        }
    }
    return false;
  }

  Future<bool> register(String email, String name, String password) async{
    try{
      bool success = await _repository.create(email, name, password);
      return success;
    }catch(e)
    {
      return false;
    }
  }


}