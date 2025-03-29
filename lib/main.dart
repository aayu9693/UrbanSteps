import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/screens/login_page.dart';
import 'package:shoes_web/screens/home_page.dart';
import 'package:shoes_web/screens/profile_page.dart';
import 'package:shoes_web/models/cart_model.dart';
import 'package:shoes_web/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD7ctiipmqHFR9LMmfWh0q0KRj6WsfvPN4",
      authDomain: "web-1e556.firebaseapp.com",
      projectId: "web-1e556",
      storageBucket: "web-1e556.appspot.com",
      messagingSenderId: "158143165355",
      appId: "1:158143165355:web:54976a5c12a7e49f9c58ee",
      measurementId: "G-0WB3J21J28",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        title: 'UrbanSteps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
        ),
        home: AuthWrapper(),
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/profile': (context) => ProfilePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user != null) {
            Provider.of<UserModel>(context, listen: false).setUser(user);
            return HomePage();
          }
          return LoginPage();
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

