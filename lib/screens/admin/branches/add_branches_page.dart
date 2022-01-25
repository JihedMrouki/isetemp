import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddbranchePage extends StatefulWidget {
  const AddbranchePage({Key? key}) : super(key: key);

  @override
  _AddbranchePageState createState() => _AddbranchePageState();
}

class _AddbranchePageState extends State<AddbranchePage> {
  final _formKey = GlobalKey<FormState>();

  var branche ="";
  var matiere = "";
  var filiere = "";
  var classe = "";
  var salle = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final brancheController = TextEditingController();
  final filiereController = TextEditingController();
  final matiereController = TextEditingController();
  final classeController = TextEditingController();
  final salleController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    brancheController.dispose();
    filiereController.dispose();
    matiereController.dispose();
    classeController.dispose();
    salleController.dispose();

    super.dispose();
  }

  clearText() {
    brancheController.clear();
    filiereController.clear();
    matiereController.clear();
    classeController.clear();
    salleController.clear();
  }

  // Adding Student
  CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  Future<void> additems() {
    return items
        .add({'branche':branche,'filiere': filiere, 'matiere': matiere,'classe':classe,'salle':salle})
        .then((value) => print('items added'))
        .catchError((error) => print('Failed to Add items: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Items"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Branche :',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: brancheController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please Enter filiere';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Filiere :',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: filiereController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please Enter matiere';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Matiere :',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: matiereController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please Enter matiere';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Class :',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: classeController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please Enter matiere';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Salle ou Labo :',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: salleController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please Enter matiere';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          branche = brancheController.text;
                          filiere = filiereController.text;
                          matiere = matiereController.text;
                          classe =classeController.text;
                          salle = salleController.text;
                          additems();
                          //addbranche
                          clearText();
                        });
                      }
                    },
                    child: const Text(
                      'add',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {clearText()},
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  ),
                  const Text("Note : these items can be added individually!"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
