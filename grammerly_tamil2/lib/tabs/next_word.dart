import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart';

List<dynamic> spell_suggestions = [""];

List<String> stringList = [""];
TextEditingController inputTextController = TextEditingController();
List<LogicalKeyboardKey> keys = [];
String text = "";
String text1 = "";

class next_word extends StatefulWidget {
  const next_word({Key? key}) : super(key: key);

  @override
  State<next_word> createState() => _next_wordState();
}

class _next_wordState extends State<next_word> {
  Future<void> call_api() async {
    print("apicalled");
    text = inputTextController.text;
    print("api_text" + text);
    Response response = await get(
        Uri.parse('http://2507-34-86-28-150.ngrok.io/spelling?name=$text'));
    print(response.toString());
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // spell_suggestions = ;
      /// for casting
      stringList = jsonResponse.cast<String>();
      print("String list" + stringList.toString());
      print("api finished");

      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) async {
        final key = event.logicalKey;
        if (event is RawKeyDownEvent) {
          if (keys.contains(key)) {
            return;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.space)) {
            call_api();
            print("after api " + stringList.toString());
            setState(() {});
          }
          setState(() {
            keys.add(key);
          });
        } else {
          setState(() {
            keys.remove(key);
          });
        }
      },
      child: Container(
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
                  onPressed: () {},
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
                  height: 20,
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
  String dropdownValue = stringList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null,
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
          inputTextController.text = "$text $dropdownValue";
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
