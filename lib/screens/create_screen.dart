import 'package:flutter/material.dart';
import 'package:flutter_crud_app/services/firebase_service.dart';

class CreateScreen extends StatefulWidget{
  const CreateScreen({super.key});

  @override
  State<StatefulWidget> createState()=>_CreateScreenState();

}

class _CreateScreenState  extends State <CreateScreen>{

  TextEditingController nameController = TextEditingController(text: ''); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear elemento'),
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

              await addMusic(nameController.text).then((_){
                    Navigator.pop(context);
              });
            }, child: const Text('Guardar'))
          ],
        ),
      )
    );
  }
}