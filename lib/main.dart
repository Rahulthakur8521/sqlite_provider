import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_provider/user_provider.dart';
import 'home_page.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider(),)
      ],
      child: MaterialApp (
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
    }
}

