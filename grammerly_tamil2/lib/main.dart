import 'package:flutter/material.dart';
import 'package:grammerly_tamil2/tabs/grammar.dart';
import 'package:grammerly_tamil2/tabs/next_word.dart';
import 'package:grammerly_tamil2/tabs/spelling.dart';
import 'package:grammerly_tamil2/tabs/synonyms.dart';

String url_base_path = "http://7b98-34-125-21-83.ngrok.io/";

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF008080),
          automaticallyImplyLeading: false,
          title: const Text(
            'Tamil Writing Aid ',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Spelling Correction',
              ),
              Tab(
                text: 'Next word Prediction',
              ),
              Tab(
                text: 'Synonyms',
              ),
              Tab(
                text: 'Grammer Correction',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [spelling(), next_word(), Synonyms(), Grammar()],
        ),
      ),
    );
  }
}
