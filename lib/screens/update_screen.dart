import 'package:flutter/material.dart';
import 'package:flutter_crud_app/services/firebase_service.dart';

class UpdateScreen extends StatefulWidget{
  const UpdateScreen({super.key});

  @override
  State<StatefulWidget> createState()=>_UpdateScreenState();

}

class _UpdateScreenState  extends State <UpdateScreen>{

  TextEditingController nameController = TextEditingController(text: ''); 


  @override
  Widget build(BuildContext context) {
    final Map arguments =ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text=arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Elemento'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             TextField(
              controller: nameController,
              decoration:  const InputDecoration(
                hintText: 'Ingrese el nombre del elemento '
              ),
            ),
            ElevatedButton(onPressed: () async{
              await updateMusic(arguments['uid'], nameController.text).then((_) {
                Navigator.pop(context);
              } );
            }, child: const Text('Actualizar'))
          ],
        ),
      )
    );
  }
}