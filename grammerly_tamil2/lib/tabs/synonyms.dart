import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

TextEditingController inputTextController = TextEditingController();

class synonyms extends StatefulWidget {
  const synonyms({Key? key}) : super(key: key);

  @override
  State<synonyms> createState() => _synonymsState();
}

class _synonymsState extends State<synonyms> {
  String text = "";
  String text1 = "";
  List<String> stringList = [""];

  Future<void> call_api() async {
    print("apicalled");
    Response response = await get(
        Uri.parse('http://8bce-34-124-190-90.ngrok.io/synonyms?word=$text'));
    // Await the http get response, then decode the json-formatted response.
    print(response.toString());
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.toString());
      stringList = jsonResponse.cast<String>();

      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () async {},
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
                    hintText: 'Enter the text to check spelling'),
              ),

              const Divider(
                height: 100,
              ),

              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal,
                  disabledForegroundColor: Colors.yellow.withOpacity(0.38),
                  side: BorderSide(color: Colors.teal, width: 2),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
                onPressed: () {
                  print(inputTextController.text);
                  text = inputTextController.text;
                  print("Hello");
                  call_api();
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Find',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              ),
// Generated code for this Button Widget..
              const Divider(
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
                  stringList.toString(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
