import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/bindings/initial_bindings.dart';
import 'package:flutter_app/themes/base_theme.dart';
import 'package:flutter_app/views/index.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Bindings _initialBindings = InitialBindings();
  final _title = 'Green Range, LLC';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return snapshot.hasError
          ? Center(
              child: Text(
                snapshot.error.toString(),
                textDirection: TextDirection.ltr,
              ),
            )
          : snapshot.connectionState == ConnectionState.done
            ? GetMaterialApp(
                title: _title,
                theme: BaseTheme.baseTheme,
                initialBinding: _initialBindings,
                home: MyHomePage(),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

