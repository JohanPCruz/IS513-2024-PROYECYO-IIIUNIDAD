import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class Comentarios extends StatefulWidget {
  @override
  _ComentariosState createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  String _comment = "";
  double _rating = 0.0;

  void _submitComentario() {
    _formKey.currentState?.save(); 
  if (_formKey.currentState?.validate() ?? false) {
    _firestore.collection('feedback').add({
      'comment': _comment,
      'rating': _rating,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Guardando feedback...'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deja tu comentario'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Comentario'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingresa un comentario';
                }
                return null;
              },
              onSaved: (value) {
                _comment = value ??"";
              },
            ),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitComentario,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
