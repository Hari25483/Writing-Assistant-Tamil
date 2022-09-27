import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

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
      child: InkWell(
        onTap: () async {},
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Divider(
              height: 100,
            ),
            RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                  print("space pressed");
                }
              },
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the text to check spelling'),
              ),
            ),
            // TextFormField(
            //   autofocus: true,
            //   obscureText: false,
            //   onChanged: (value) => setState(() => text = value),
            //   decoration: const InputDecoration(
            //     hintText: 'Enter the text to check spelling\n',
            //     hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Color(0x00000000),
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(4.0),
            //         topRight: Radius.circular(4.0),
            //       ),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Color(0x00000000),
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(4.0),
            //         topRight: Radius.circular(4.0),
            //       ),
            //     ),
            //     errorBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Color(0x00000000),
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(4.0),
            //         topRight: Radius.circular(4.0),
            //       ),
            //     ),
            //     focusedErrorBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Color(0x00000000),
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(4.0),
            //         topRight: Radius.circular(4.0),
            //       ),
            //     ),
            //   ),
            //   style: const TextStyle(fontSize: 20.0, color: Colors.black),
            //   textAlign: TextAlign.center,
            // ),
            const Divider(
              height: 100,
            ),
            // MaterialButton(
            //     color: Colors.teal,
            //     child: Text(
            //       'Find',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     onPressed: () async {
            //       print('Pressed');
            //       print(text);
            //       // var url = Uri.https('https://api.genderize.io/?name=luc');
            //       Response response = await get(
            //           Uri.parse('http://35ec-35-231-30-146.ngrok.io/'));
            //       // Await the http get response, then decode the json-formatted response.
            //       // var response = await http.get(url);
            //       print(response.toString());
            //       if (response.statusCode == 200) {
            //         var jsonResponse = convert.jsonDecode(response.body)
            //             as Map<String, dynamic>;
            //         var itemCount = jsonResponse['Hello'];
            //         text1 = "$itemCount";
            //         print(text1);
            //         setState(() {});
            //       } else {
            //         print(
            //             'Request failed with status: ${response.statusCode}.');
            //       }
            //
            //       // print(await http.read(Uri.https('example.com', 'foobar.txt')));
            //       // text = "Hello";),
            //     }),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                disabledForegroundColor: Colors.yellow.withOpacity(0.38),
                side: BorderSide(color: Colors.teal, width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              onPressed: () async {
                print('Pressed');
                print(text);
                // var url = Uri.https('https://api.genderize.io/?name=luc');
                Response response =
                    await get(Uri.parse('http://35ec-35-231-30-146.ngrok.io/'));
                // Await the http get response, then decode the json-formatted response.
                // var response = await http.get(url);
                print(response.toString());
                if (response.statusCode == 200) {
                  var jsonResponse =
                      convert.jsonDecode(response.body) as Map<String, dynamic>;
                  var itemCount = jsonResponse['Hello'];
                  text1 = "$itemCount";
                  print(text1);
                  setState(() {});
                } else {
                  print('Request failed with status: ${response.statusCode}.');
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

            const Divider(
              height: 50,
            ),
            Text(text1), // display your text
          ],
        ),
      ),
    );
  }
}
