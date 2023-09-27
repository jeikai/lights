import 'package:flutter/material.dart';

class FormDepression extends StatelessWidget {
  const FormDepression({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Table(
            border: null,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Colors.redAccent),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('cell 1'),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('cell 2'),
                    ),
                  ),
                ],
              ),
              ...List.generate(
                  10,
                  (index) => const TableRow(children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('cell 2'),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('cell 2'),
                          ),
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
