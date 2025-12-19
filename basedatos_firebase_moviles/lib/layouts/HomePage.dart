import 'package:flutter/material.dart';

import '../services/firebase_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(title: Text("Fluter+Firebase"),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/add');
            }, icon: Icon(Icons.add)),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/home');
            }, icon: Icon(Icons.home))
          ],),
        body: Center(
      child: FutureBuilder(future: getAllUsers(),
          builder: ((context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (
                    ){
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data?[index]['name']),
                          SizedBox(height: 10),
                          Text(snapshot.data?[index]['email'])
                        ],
                      )
                      ,
                    ),
                  );
                },
              );
            }
            else
              {
                return CircularProgressIndicator();
              }
          }),
      )
    ));
  }
}
