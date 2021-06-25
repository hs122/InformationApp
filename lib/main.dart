import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('admin');

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _phoneTEC = TextEditingController();
  TextEditingController _accountTEC = TextEditingController();
  TextEditingController _ifscTEC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<void> addItem({
    required String name,
    required String email,
    required String phone,
    required String account,
    required String ifsc,
  }) async {
    // ignore: unused_local_variable
    DocumentReference documentReferencer =
        _mainCollection.doc().collection('admin').doc();
    // ignore: unused_local_variable
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "phone": phone,
      "account": account,
      "ifsc": ifsc,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Flutter Application"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 120,
                          backgroundImage:
                              AssetImage("assets/images/Profile.png"),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Information',
                              // ignore: deprecated_member_use
                              style: GoogleFonts.lato(
                                  // ignore: deprecated_member_use
                                  textStyle:
                                      // ignore: deprecated_member_use
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _nameTEC,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _emailTEC,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your email"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _phoneTEC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your PhoneNumber"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _accountTEC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your AccountNumber"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _ifscTEC,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your IFSC CODE"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  child: Text("Submit"),
                                  onPressed: () => {
                                        if (!_formkey.currentState!.validate())
                                          {}
                                        else
                                          {
                                            addItem(
                                              name: _nameTEC.text,
                                              email: _emailTEC.text,
                                              phone: _phoneTEC.text,
                                              account: _accountTEC.text,
                                              ifsc: _ifscTEC.text,
                                            ),
                                            showAlertDialog(context)
                                          }
                                      })
                            ]),
                      ],
                    )))));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  // ignore: deprecated_member_use
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
