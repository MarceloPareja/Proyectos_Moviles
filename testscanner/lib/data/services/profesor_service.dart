import '../remote_repositories/profesor_repository.dart';
import '../../domain/entities/profesor.dart';
class ProfesorService {
  ProfesorRepository _repository = ProfesorRepository();

  Future<bool> login (String usuario, String clave)async{
    final data= await _repository.getRawList();
    for(var item in data){
      if(usuario==item["email"] && clave==item["password"])
        {
          return true;
        }
    }
    return false;
  }

  Future<bool> register(String email, String name, String password) async{
    try{
      if(!await checkNonExisting(email))
        {
          return false;
        }
      bool success = await _repository.create(email, name, password);
      return success;
    }catch(e)
    {
      return false;
    }
  }

  Future<Profesor> getByMail(String email) async
  {
    late Profesor profesor;
    List<Profesor> data= await _repository.getList();
    for(var item in data)
      {
        if(item.email==email)
          {
            profesor=item;
          }
      }
    return profesor;
  }

  Future<bool> checkNonExisting(String email) async
  {
    try{
      List<Profesor> lista = await _repository.getList();
      for(var item in lista)
        {
          if(item.email==email)
            {
              return false;
            }
        }
      return true;
    }catch(e)
    {
      return false;
    }
  }


}