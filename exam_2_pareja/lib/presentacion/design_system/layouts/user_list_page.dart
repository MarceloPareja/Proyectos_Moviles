import '../../design_system/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../datos/repository_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

    void init_message() async{
      String? token=await FirebaseMessaging.instance.getToken();
      print("Token ${token}");

      FirebaseMessaging.onMessage.listen((message){
        String title=message.notification?.title ?? "N/A";
        String body=message.notification?.body ?? "N/A";
        showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text(title),
            content: Text(body, maxLines: 1, overflow: TextOverflow.ellipsis,),
          ));
        });
      }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    init_message();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: FutureBuilder(future: RepositoryImpl().getAllUsers(),
            builder: (context, snapshot)
        {
          if(snapshot.hasData)
            {
              print(snapshot.data);
              return ListView.builder(itemCount: snapshot.data?.length,
                itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: Text(snapshot.data?[index].username),
                    trailing: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          RepositoryImpl().deleteUser(snapshot.data?[index].id);
                          setState(() {
                          });
                        }, icon: Icon(Icons.delete)),
                        IconButton(onPressed: (){
                          RepositoryImpl().deleteUser(snapshot.data?[index].id);
                          setState(() {
                          });
                        }, icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
                },
              );
            }
          else{
            return CircularProgressIndicator();
          }
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(onPressed: (){
            Navigator.pushNamed(context, "/add");
          },
          child: Icon(Icons.person_add),)
        ],
      ),
    );
  }
}
