import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          ////-----------------------------------------
          FutureBuilder(
            future: getMusic(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: ((context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async{
                        await deleteMusic(snapshot.data?[index]['uid']);
                        snapshot.data?.removeAt(index);
                      },
                      confirmDismiss: (direction) async{
                        bool confirmDelete =false;
                        confirmDelete = await showDialog(context: context, builder: (context){
                          return  AlertDialog(title: Text('¿Estás seguro de querer eliminar ${snapshot.data?[index]['name']}?'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                return Navigator.pop( context,false,);
                              }, child: const Text('Cancelar', style: TextStyle(color: Colors.red),)
                              ),
                              TextButton(
                              onPressed: (){
                                return Navigator.pop( context,true,);
                              }, child: const Text('Si, Estoy Seguro')
                              )

                          ],);
                        });
                        return confirmDelete;
                        },
                      
                      key: Key(snapshot.data?[index]['uid']),
                      background:Container( color:const Color.fromARGB(255, 224, 58, 46),
                      child:  const Row(
                        mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment : MainAxisAlignment.center
                         ,
                        children: [
                          Icon(Icons.delete, color: Colors.white,),
                          Text('Eliminar', style: TextStyle(color: Colors.white),)

                        ],
                      ),
                      ),

                      child: ListTile(
                        title: Text(snapshot.data?[index]['name']),
                        onTap: (() async{
                          await Navigator.pushNamed(context,'/edit', arguments: {
                            "name":snapshot.data?[index]['name'],
                            "uid":snapshot.data?[index]['uid'],
                          });
                           setState(() { });
                        })
                      ),
                    );
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async{
              await Navigator.pushNamed(context, '/create');

              setState(() { });
            },
            child: const Icon(Icons.create),
          ),
        
      
    );
  }
}
