import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotlas_test/provider/liked_provider.dart';
import 'package:spotlas_test/provider/list_provider.dart';
import 'package:spotlas_test/provider/saved_provider.dart';
import 'package:spotlas_test/view/feed.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FeedListProvider(),),
     ChangeNotifierProvider(create: (context) => SavedProvider(),),
      ChangeNotifierProvider(create: (context) => LikedProvider(),)
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedListProvider>(context, listen: false).updateFeed(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spotlas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Feed());
  }
}
