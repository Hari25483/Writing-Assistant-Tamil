import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

List<dynamic> spell_suggestions = [""];

List<String> stringList = [];
TextEditingController inputTextController = TextEditingController();

/// string list

class spelling extends StatefulWidget {
  const spelling({Key? key}) : super(key: key);

  @override
  State<spelling> createState() => _spellingState();
}

class _spellingState extends State<spelling> {
  String text = "";
  String text1 = "";

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
                  hintText: 'Enter the text to check spelling',
                ),
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
                onPressed: () async {
                  text = inputTextController.text;
                  // var url = Uri.https('https://api.genderize.io/?name=luc');
                  Response response = await get(Uri.parse(
                      'http://2624-34-86-28-150.ngrok.io/spelling?name=$text'));
                  // Await the http get response, then decode the json-formatted response.
                  // var response = await http.get(url);
                  print(response.toString());
                  if (response.statusCode == 200) {
                    var jsonResponse = convert.jsonDecode(response.body);
                    print("list" + jsonResponse.toString());
                    spell_suggestions = jsonResponse;

                    /// for casting
                    stringList = spell_suggestions.cast<String>();
                    // text1 = "$jsonResponse";
                    // print(text1);
                    setState(() {});
                  } else {
                    print(
                        'Request failed with status: ${response.statusCode}.');
                  }

                  // print(await http.read(Uri.https('example.com', 'foobar.txt')));
                  // text = "Hello";
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

              // Container(
              //   margin: const EdgeInsets.all(15.0),
              //   padding: const EdgeInsets.all(3.0),
              //   width: 300,
              //   height: 50,
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              //   child: Text(
              //     text1,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const DropdownButtonExample()
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = spell_suggestions.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      iconEnabledColor: Colors.green,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          inputTextController.text = dropdownValue;
        });
      },
      items: stringList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
