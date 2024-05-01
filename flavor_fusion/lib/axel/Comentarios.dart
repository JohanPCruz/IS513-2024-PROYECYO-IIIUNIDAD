import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comentarios extends StatefulWidget {
  const Comentarios({Key? key});

  @override
  _ComentariosState createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String _comment = "";
  double _rating = 0.0;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void _submitComentario() {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() ?? false) {
      _firestore.collection('feedback').add({
        'comment': _comment,
        'rating': _rating,
        'userId': _user?.uid,
        'userName': _user?.displayName,
        'userPhotoUrl': _user?.photoURL,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Guardando feedback...'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _formKey.currentState?.reset();
      setState(() {
        _comment = '';
        _rating = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Opiniones de los usuarios',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('feedback').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final comments = snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final commentText = comment['comment'];
                        final rating = comment['rating'];
                        final data = comment.data() as Map<String, dynamic>?;
                        final userName = data?['userName'] ?? 'Usuario desconocido';
                        final userPhotoUrl = data?['userPhotoUrl'] ?? '';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBarIndicator(
                                    rating: rating.toDouble(),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    unratedColor: Colors.grey[300]!,
                                  ),
                                  Text(
                                    'Hace ${comments.length - index} días',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: userPhotoUrl.isNotEmpty ? NetworkImage(userPhotoUrl) : AssetImage('assets/placeholder_image.png') as ImageProvider<Object>,
                                ),
                                title: Text(userName),
                              ),
                              Text(
                                commentText,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comentario'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingresa un comentario';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = value ?? "";
                },
              ),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _user != null ? _submitComentario : null,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
