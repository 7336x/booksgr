import 'package:booksgr/pages/add_page.dart';
import 'package:booksgr/pages/home_page.dart';
import 'package:booksgr/pages/signin_page.dart';
import 'package:booksgr/pages/signup_page.dart';
import 'package:booksgr/pages/update_page.dart';
import 'package:booksgr/providers/auth_provider.dart';
import 'package:booksgr/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BooksProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => AddPage(),
      ),
      GoRoute(
        path: '/update/:bookId',
        builder: (context, state) {
          final book = Provider.of<BooksProvider>(context).books.firstWhere(
              (book) =>
                  book.id.toString() == (state.pathParameters['bookId']!));
          return UpdatePage(book: book);
        },
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SigninPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
    ],
  );
}
