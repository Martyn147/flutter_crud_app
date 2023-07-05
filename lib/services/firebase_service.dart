import 'package:cloud_firestore/cloud_firestore.dart';



Future<List> getMusic() async {
  List music = [];
  await FirebaseFirestore.instance.collection('musica').get().then((QuerySnapshot querySnapshot) {
     for (var doc in querySnapshot.docs) {
            final Map<String, dynamic>data = doc.data() as Map<String, dynamic>;
            final musica ={
              'name': data['name'],
              'uid':doc.id,
            };
            print(doc["name"]);
            music.add(musica);
        }
  });
   Future.delayed(const Duration(seconds: 1));
  return music;
}


Future <void> addMusic(String name) async{
  await FirebaseFirestore.instance.collection('musica').add({'name': name});

}

Future <void> updateMusic(String uid, String newname ) async{
  await FirebaseFirestore.instance.collection('musica').doc(uid).set({'name': newname});

}

Future <void> deleteMusic(String uid) async{
  await FirebaseFirestore.instance.collection('musica').doc(uid).delete();

}