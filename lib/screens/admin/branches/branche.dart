import 'package:flutter/material.dart';

import 'add_branches_page.dart';
import 'list_branches.dart';

class BranchePage extends StatefulWidget {
  const BranchePage({Key? key}) : super(key: key);

  @override
  State<BranchePage> createState() => _BranchePageState();
}

class _BranchePageState extends State<BranchePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Addition Menu'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddbranchePage(),
                  ),
                )
              },
              child: const Text('Add',
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
              style: ElevatedButton.styleFrom(primary: Colors.white),
            )
          ],
        ),
      ),
      body: const ListbranchePage(),
    );
  }
}
