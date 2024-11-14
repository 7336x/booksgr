import 'package:booksgr/models/book.dart';
import 'package:booksgr/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              book.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(book.title),
                  Text("author: ${book.author}"),
                  Text("price: ${book.price}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            GoRouter.of(context).push('/update/${book.id}');
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Provider.of<BooksProvider>(context, listen: false)
                                .deleteBook(book.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
