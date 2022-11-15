import 'dart:convert' as convert;

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

class Synonyms extends StatefulWidget {
  const Synonyms({Key? key}) : super(key: key);

  @override
  State<Synonyms> createState() => _SynonymsState();
}

class _SynonymsState extends State<Synonyms> {
  Future<void> call_api() async {
    print("apicalled");
    text = inputTextController.text;
    print("api_text$text");
    Response response =
        await get(Uri.parse('$url_base_path/synonyms?word=$text'));
    print(response.toString());
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      /// for casting
      stringList = jsonResponse.cast<String>();
      print("String list$stringList");
      print("api finished");

      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rawkey$stringList");
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
    return Scaffold(
      body: Container(
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
                hintText: 'Enter the text to find synonyms',
              ),
            ),

            const SizedBox(
              height: 100,
            ),

            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.teal,
                  disabledForegroundColor: Colors.yellow.withOpacity(0.38),
                  side: const BorderSide(color: Colors.teal, width: 2),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                onPressed: () async {
                  await call_api();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 2.0),
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
            ),
// Generated code for this Button Widget..
            const SizedBox(
              height: 20,
            ),
            if (stringList.isNotEmpty)
              const Center(child: DropdownButtonExample())
          ],
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
    print("in Widget" + stringList.toString());
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
//
// import 'package:http/http.dart';
//
// List<String> stringList = [""];
// String text = "";
// String text1 = "";
// TextEditingController inputTextController = TextEditingController();
//
// class synonyms extends StatefulWidget {
//   const synonyms({Key? key}) : super(key: key);
//
//   @override
//   State<synonyms> createState() => _synonymsState();
// }
//
// class _synonymsState extends State<synonyms> {
//   Future<void> call_api() async {
//     print("apicalled");
//     Response response = await get(
//         Uri.parse('http://d343-34-75-88-187.ngrok.io/synonyms?word=$text'));
//     // Await the http get response, then decode the json-formatted response.
//     print(response.toString());
//     if (response.statusCode == 200) {
//       var jsonResponse = convert.jsonDecode(response.body);
//       print(jsonResponse.toString());
//       stringList = jsonResponse.cast<String>();
//
//       setState(() {});
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }
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
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter the text to check spelling'),
//               ),
//
//               const Divider(
//                 height: 100,
//               ),
//
//               TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.teal,
//                   disabledForegroundColor: Colors.yellow.withOpacity(0.38),
//                   side: BorderSide(color: Colors.teal, width: 2),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//                 onPressed: () {
//                   print(inputTextController.text);
//                   text = inputTextController.text;
//                   print("Hello");
//                   call_api();
//                   setState(() {});
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
//               //   height: 150,
//               //   decoration:
//               //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//               //   child: Text(
//               //     stringList.toString(),
//               //     textAlign: TextAlign.center,
//               //   ),
//               // ),
//               const Center(child: DropdownButtonExample())
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
//   String dropdownValue = stringList.first;
//
//   @override
//   Widget build(BuildContext context) {
//     print("in Widget" + stringList.toString());
//     return DropdownButton<String>(
//       value: null,
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
//           inputTextController.text = "$text $dropdownValue";
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
