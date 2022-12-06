import 'dart:convert';
import 'dart:io';

import 'package:final_project/classes/Entrada.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

  final Entrada entrada = Entrada('hello', 'en', 'pt');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Node server demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Client')),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String serverResponse = 'Server response';
	final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: BootstrapContainer(
					fluid:true,
					decoration: const BoxDecoration(
						color: Colors.white,
					),
					padding: const EdgeInsets.only(top:0),
					children: <Widget>[
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Form(
                    key: _formKey,
                    child: BootstrapRow(
                      children: [
                        BootstrapCol(
                          sizes: 'col-12',
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Enter your phrase',
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            onSaved: (value) => {
                              setState(() {
                                if(value != null) {
                                  entrada.input = value;
                                }
                              })
                            },
                            validator: (value){
                              if(value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                            }
                          ),
                        ),
                        BootstrapCol(
                          sizes: 'col-12',
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              setState(() {
                                _makeGetRequest();
                              });

                            },
                            child: Text('Send'),
                          ),
                        ),
                      ],
                      )
                  )
                ),
              ],
              ),
            BootstrapRow(
              children: [
                BootstrapCol(
                  sizes: 'col-12',
                  child: Text(serverResponse),
                ),
              ],
            ),
          ]
      )
    );
  }

  _makeGetRequest() async {
    var input = entrada.input;
    var source = entrada.source;
    var target = entrada.target;
    // final url = Uri.parse(_localhost(input, source, target));
    final url = Uri(
      scheme: 'http',
      host: _localhost(),
      port: 8080,
      path: '/',
      queryParameters: {
        'input': input,
        'source': source,
        'target': target,
      },
    );
    print(url);
    
    Response response = await get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });

    Future.delayed(const Duration(microseconds: 100), () {
       setState(() {
          serverResponse = jsonDecode(response.body);
        });
      });
   
  }


  String _localhost() {
    String url = '';
    setState(() {
      if (Platform.isAndroid) {
        url = '10.0.2.2';
      } else {
        url ='localhost';
      }
    });
    return url;
  }
  
}