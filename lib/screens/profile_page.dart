import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  User? _user;
  String _name = '';
  String _email = '';
  String _phone = '';
  String _avatarUrl = '';
  bool _isEditing = false;
  bool _isLoading = true;
  File? _imageFile;

  final List<String> _predefinedAvatars = [
    'https://example.com/avatar1.png',
    'https://example.com/avatar2.png',
    'https://example.com/avatar3.png',
    'https://example.com/avatar4.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _user = Provider.of<UserModel>(context, listen: false).user;
      if (_user == null) {
        throw Exception('User is null');
      }

      DocumentSnapshot doc = await _firestore.collection('users').doc(_user!.uid).get();
      if (doc.exists) {
        setState(() {
          _name = doc['displayName'] ?? '';
          _email = doc['email'] ?? '';
          _phone = doc['phone'] ?? '';
          _avatarUrl = doc['avatarUrl'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user details. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // TODO: Implement image upload to Firebase Storage and get the URL
        String imageUrl = _avatarUrl;
        if (_imageFile != null) {
          // Upload image and get URL
          // imageUrl = await uploadImage(_imageFile!);
        }

        await _firestore.collection('users').doc(_user!.uid).update({
          'displayName': _name,
          'phone': _phone,
          'avatarUrl': imageUrl,
        });
        setState(() {
          _isEditing = false;
          _avatarUrl = imageUrl;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildAvatarSelector() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!)
              : (_avatarUrl.isNotEmpty
              ? NetworkImage(_avatarUrl)
              : AssetImage('assets/default_avatar.png')) as ImageProvider,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _isEditing ? _pickImage : null,
          child: Text('Change Picture'),
        ),
        SizedBox(height: 10),
        if (_isEditing)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _predefinedAvatars.map((url) => GestureDetector(
              onTap: () {
                setState(() {
                  _avatarUrl = url;
                  _imageFile = null;
                });
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(url),
              ),
            )).toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isLoading
                ? null
                : () {
              if (_isEditing) {
                _updateProfile();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _user == null
          ? Center(child: Text('User not found. Please log in again.'))
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAvatarSelector(),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.person),
                          ),
                          enabled: _isEditing,
                          validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                          onChanged: (value) => _name = value,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _phone,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            icon: Icon(Icons.phone),
                          ),
                          enabled: _isEditing,
                          validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
                          onChanged: (value) => _phone = value,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (!_isEditing)
                  ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    label: Text('Sign Out'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

