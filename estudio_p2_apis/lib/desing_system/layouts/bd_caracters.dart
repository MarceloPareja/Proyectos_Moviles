import 'package:flutter/material.dart';
import '../../services/database/firestore_db_service.dart';
import '../components/my_app_bar.dart';
class BdCaracters extends StatefulWidget {
  const BdCaracters({super.key});

  @override
  State<BdCaracters> createState() => _BdCaractersState();
}

class _BdCaractersState extends State<BdCaracters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Container(
          child: Center(
              child: FutureBuilder(future: getAllCharacters(), builder:
              (context,snapshot){
                if(snapshot.hasData)
                  {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context,index) {
                            return Card(
                              color: Theme.of(context).colorScheme.onSecondary,
                                child: ListTile(
                                    leading: SizedBox(width: 40, height: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          snapshot.data?[index]['Image'],
                                        ),
                                      ),),
                                    title: Text(snapshot.data?[index]['name']),
                                    subtitle: Text(
                                        snapshot.data?[index]['planet'])
                                )
                            );
                          }
                      );
                  }
                else{
                  return CircularProgressIndicator();
                }

              }
              )
          ),
        )
    );
  }
}
