import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UpdateBranche.dart';

class ListbranchePage extends StatefulWidget {
  const ListbranchePage({Key? key}) : super(key: key);

  @override
  _ListbranchePageState createState() => _ListbranchePageState();
}

class _ListbranchePageState extends State<ListbranchePage> {
  final Stream<QuerySnapshot> brancheStream =
      FirebaseFirestore.instance.collection('items').snapshots();

  // For Deleting User
  CollectionReference branche =
      FirebaseFirestore.instance.collection('items');
  Future<void> deletebranche(id) {
    // print("User Deleted $id");
    return branche
        .doc(id)
        .delete()
        .then((value) => print('items Deleted'))
        .catchError((error) => print('Failed to Delete items: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: brancheStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'branche',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'filiere',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'matiere',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'classe',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'salle',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['branche'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['filiere'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                         TableCell(
                          child: Center(
                              child: Text(storedocs[i]['matiere'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                         TableCell(
                          child: Center(
                              child: Text(storedocs[i]['classe'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                         TableCell(
                          child: Center(
                              child: Text(storedocs[i]['salle'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateStudentPage(
                                          id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deletebranche(storedocs[i]['id'])},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
