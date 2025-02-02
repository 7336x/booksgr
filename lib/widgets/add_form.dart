import 'dart:io';
import 'package:booksgr/models/book.dart';
import 'package:booksgr/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddBookForm extends StatefulWidget {
  @override
  UpdateFormState createState() {
    return UpdateFormState();
  }
}

class UpdateFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  var _image;
  String title = "";
  String author = "";
  double price = 0;
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Book book = Book(title: "", author: "", price: 0, image: "");
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Book title',
            ),
            initialValue: book.title,
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              title = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Book author',
            ),
            initialValue: book.author,
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              author = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'book price',
            ),
            initialValue: book.price.toString(),
            validator: (value) {
              if (value == null) {
                return "please enter a price";
              } else if (double.tryParse(value) == null) {
                return "please enter a number";
              }
              return null;
            },
            onSaved: (value) {
              price = double.parse(value!);
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  child: _image != null
                      ? Image.file(
                          _image,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(
                          decoration: BoxDecoration(color: Colors.blue[200]),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Image"),
              )
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  _formKey.currentState!.save();
                  Provider.of<BooksProvider>(context, listen: false).createBook(
                      Book(
                          id: book.id,
                          title: title,
                          author: author,
                          image: _image.path,
                          price: price));
                  GoRouter.of(context).pop();
                }
              },
              child: const Text("create Book"),
            ),
          )
        ],
      ),
    );
  }
}
