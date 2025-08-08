import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pratices/view/task_list_screen.dart';
import 'package:pratices/viewmodel/task_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => TaskViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TaskListScreen(),
      ),
    );
  }
}
