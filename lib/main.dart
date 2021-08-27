import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/providers/menuProvider.dart';
import 'package:scanner/src/providers/scannerProvider.dart';
import 'package:scanner/src/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => ScannerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          ),
        ),

        initialRoute: '/home',

        routes: {
          '/home': (BuildContext context) => HomeScreen(),
        },
      ),
    );
  }
}