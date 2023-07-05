import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_crud_app/screens/create_screen.dart';
import 'package:flutter_crud_app/screens/home_screen.dart';
import 'package:flutter_crud_app/screens/update_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Crud App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=>const HomeScreen(),
        '/create': (context)=> const CreateScreen(),
        '/edit': (context)=> const UpdateScreen(),

      },
    );
  }
}