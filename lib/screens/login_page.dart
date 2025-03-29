import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/models/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  String _email = '';
  String _password = '';
  String _name = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential;
        if (_isSignUp) {
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          await userCredential.user!.updateDisplayName(_name);
        } else {
          userCredential = await _auth.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        }
        final User? user = userCredential.user;
        if (user != null) {
          await _storeUserData(user);
          Provider.of<UserModel>(context, listen: false).setUser(user);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful! Welcome, ${user.displayName ?? user.email}')),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _storeUserData(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'displayName': user.displayName ?? _name,
      'email': user.email,
      'lastSignIn': FieldValue.serverTimestamp(),
      'phone': '',
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[300]!, Colors.purple[300]!],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Welcome to UrbanSteps',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_isSignUp)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                              onSaved: (value) => _name = value!,
                            ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            validator: (value) => !value!.contains('@') ? 'Please enter a valid email' : null,
                            onSaved: (value) => _email = value!,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            obscureText: true,
                            validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            child: Text(
                              _isLoading ? 'Processing...' : (_isSignUp ? 'Sign Up' : 'Sign In'),
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              backgroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 5,
                            ),
                            onPressed: _isLoading ? null : _handleSignIn,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      child: Text(
                        _isSignUp ? 'Already have an account? Sign In' : 'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => setState(() => _isSignUp = !_isSignUp),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'By signing in, you agree to our Terms of Service and Privacy Policy',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

