// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
//
// import 'package:http/http.dart';
//
// List<dynamic> spell_suggestions = [""];
//
// List<String> stringList = [];
// TextEditingController inputTextController = TextEditingController();
//
// /// string list
//
// class spelling extends StatefulWidget {
//   const spelling({Key? key}) : super(key: key);
//
//   @override
//   State<spelling> createState() => _spellingState();
// }
//
// class _spellingState extends State<spelling> {
//   String text = "";
//   String text1 = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SingleChildScrollView(
//         child: InkWell(
//           onTap: () async {},
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Divider(
//                 height: 100,
//               ),
//               TextField(
//                 controller: inputTextController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter the text to check spelling',
//                 ),
//               ),
//
//               const Divider(
//                 height: 100,
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.teal,
//                   disabledForegroundColor: Colors.yellow.withOpacity(0.38),
//                   side: BorderSide(color: Colors.teal, width: 2),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//                 onPressed: () async {
//                   text = inputTextController.text;
//                   // var url = Uri.https('https://api.genderize.io/?name=luc');
//                   Response response = await get(Uri.parse(
//                       'http://e0e3-35-199-34-149.ngrok.io/spelling?name=$text'));
//                   // Await the http get response, then decode the json-formatted response.
//                   // var response = await http.get(url);
//                   print(response.toString());
//                   if (response.statusCode == 200) {
//                     var jsonResponse = convert.jsonDecode(response.body);
//                     print("list" + jsonResponse.toString());
//                     spell_suggestions = jsonResponse;
//
//                     /// for casting
//                     stringList = spell_suggestions.cast<String>();
//                     // text1 = "$jsonResponse";
//                     // print(text1);
//                     setState(() {});
//                   } else {
//                     print(
//                         'Request failed with status: ${response.statusCode}.');
//                   }
//
//                   // print(await http.read(Uri.https('example.com', 'foobar.txt')));
//                   // text = "Hello";
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text('Find',
//                       style: TextStyle(
//                           color: Colors.teal,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500)),
//                 ),
//               ),
// // Generated code for this Button Widget..
//               const Divider(
//                 height: 50,
//               ),
//
//               // Container(
//               //   margin: const EdgeInsets.all(15.0),
//               //   padding: const EdgeInsets.all(3.0),
//               //   width: 300,
//               //   height: 50,
//               //   decoration:
//               //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//               //   child: Text(
//               //     text1,
//               //     textAlign: TextAlign.center,
//               //   ),
//               // ),
//               const DropdownButtonExample()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({super.key});
//
//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }
//
// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = spell_suggestions.first;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       // icon: const Icon(Icons.arrow_downward),
//       iconEnabledColor: Colors.green,
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//           inputTextController.text = dropdownValue;
//         });
//       },
//       items: stringList.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

import 'dart:convert' as convert;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../main.dart';

List<dynamic> spell_suggestions = [""];

List<String> stringList = [];
TextEditingController inputTextController = TextEditingController();
List<LogicalKeyboardKey> keys = [];
String text = "";
String text1 = "";
bool correct = false;
bool show_text = false;

class spelling extends StatefulWidget {
  const spelling({Key? key}) : super(key: key);

  @override
  State<spelling> createState() => _spellingState();
}

class _spellingState extends State<spelling> {
  void showToast() {
    setState(() {
      correct = !correct;
    });
  }

  Future<void> call_api() async {
    show_text = false;
    text = inputTextController.text;
    String s = text.trim();
    String lastWord = s.substring(s.lastIndexOf(" ") + 1);
    print(lastWord);
    Response response =
        await get(Uri.parse('$url_base_path/spelling?word=$lastWord'));
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse == "Your word seems to be correct") {
        //print("Correct");
        correct = true;
        setState(() {});
      } else {
        correct == false;
        show_text = true;
        stringList = jsonResponse.cast<String>();
        //print("String list" + stringList.toString());
        //print("api finished");
        setState(() {});
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Rawkey" + stringList.toString());
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) async {
          final key = event.logicalKey;
          if (event is RawKeyDownEvent) {
            print("1");
            if (keys.contains(key)) {
              return;
            }
            print(keys);
            setState(() {
              keys.add(key);
            });
            if (event.isKeyPressed(LogicalKeyboardKey.space)) {
              print("in");
              await call_api();

              keys.clear();
              if (correct == true) {
                //print("Correct word");
              } else {
                //print("after api " + stringList.toString());
              }
            }
          } else {
            setState(() {
              keys.remove(key);
            });
          }
        },
        child: Container(
          // color: Colors.red,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
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
                  hintText: 'Enter the text to check spelling',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (stringList.isNotEmpty)
                Wrap(
                  children: [
                    for (String word in stringList)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: GestureDetector(
                          onTap: () async {
                            inputTextController.text = word;
                            setState(() {});

                            stringList = [];
                            show_text = false;
                            setState(() {});
                          },
                          child: Chip(
                            label: Text(word),
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(
                height: 100,
              ),
              Visibility(
                visible: stringList.isNotEmpty,
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Your word seems wrong.',
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 1),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1),
                    displayFullTextOnTap: true,

                    // stopPauseOnTap: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              // Center(
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       foregroundColor: Colors.teal,
              //       disabledForegroundColor: Colors.yellow.withOpacity(0.38),
              //       side: BorderSide(color: Colors.teal, width: 2),
              //       shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(25))),
              //     ),
              //     onPressed: () {},
              //     child: const Padding(
              //       padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //       child: Text('Find',
              //           style: TextStyle(
              //               color: Colors.teal,
              //               fontSize: 14,
              //               fontWeight: FontWeight.w500)),
              //     ),
              //   ),
              // ),
// Generated code for this Button Widget..
              const SizedBox(
                height: 20,
              ),
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
  String dropdownValue = stringList.first;

  @override
  Widget build(BuildContext context) {
    // print("in Widget" + stringList.toString());
    return DropdownButton<String>(
      value: null,
      icon: const Icon(Icons.arrow_downward),
      iconEnabledColor: Colors.black54,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.black54,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          //print(inputTextController.text.split(" "));
          List<String> before_String =
              inputTextController.text.trim().split(" ");
          int len = before_String.length;
          String output_text = "";
          for (int i = 0; i < len - 1; i++) {
            output_text = output_text + " " + before_String[i];
          }

          inputTextController.text = "$output_text $dropdownValue";
          show_text = false;
          stringList = [];
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
