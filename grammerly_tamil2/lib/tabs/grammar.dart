import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:grammerly_tamil2/main.dart';
import 'package:http/http.dart';

TextEditingController inputTextController = TextEditingController();

class Grammar extends StatefulWidget {
  const Grammar({Key? key}) : super(key: key);

  @override
  State<Grammar> createState() => _GrammarState();
}

class _GrammarState extends State<Grammar> {
  String text = "";
  String text1 = "";
  List<String> stringList = [""];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Divider(
              height: 100,
            ),
            TextField(
              controller: inputTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  hintText: 'Enter the text to find correct grammar'),
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.teal,
                disabledForegroundColor: Colors.yellow.withOpacity(0.38),
                side: const BorderSide(color: Colors.teal, width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              onPressed: () async {
                print(inputTextController.text);
                text = inputTextController.text;
                Response response = await get(Uri.parse(
                    '$url_base_path/grammar_suggestion?word=grammar: $text'));
                // Await the http get response, then decode the json-formatted response.
                print(response.toString());
                if (response.statusCode == 200) {
                  var jsonResponse = convert.jsonDecode(response.body);
                  print(jsonResponse.toString());
                  text1 = jsonResponse.toString();
                  setState(() {});
                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Find',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              width: 300,
              height: 150,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Text(
                text1,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
