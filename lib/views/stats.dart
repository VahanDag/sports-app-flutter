import 'package:flutter/material.dart';
import 'package:sports_app/core/extensions.dart';

class Stats extends StatelessWidget {
  const Stats({super.key, this.textColor});

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
            columnSpacing: 10,
            columns: <DataColumn>[
              DataColumn(label: _text(text: 'Club')),
              DataColumn(label: _text(text: 'MP')),
              DataColumn(label: _text(text: 'W')),
              DataColumn(label: _text(text: 'D')),
              DataColumn(label: _text(text: 'L')),
              DataColumn(label: _text(text: 'GF')),
              DataColumn(label: _text(text: 'GA')),
              DataColumn(label: _text(text: 'GD')),
              DataColumn(label: _text(text: 'Pts')),
            ],
            rows: List.generate(
                18,
                (index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _text(style: context.textTheme.titleSmall?.copyWith(color: textColor), text: "${index + 1}- "),
                              _text(text: "Liverpool", style: context.textTheme.titleSmall?.copyWith(color: textColor))
                            ],
                          ),
                        )), // 1'den başlayan indeks
                        DataCell(_text(text: index * 13)),
                        DataCell(_text(text: index * 6)),
                        DataCell(_text(text: index * 8)),
                        DataCell(_text(text: index * 4)),
                        DataCell(_text(text: index * 3)),
                        DataCell(_text(text: index * 7)),
                        DataCell(_text(text: index * 1)),
                        DataCell(_text(
                          text: index * 9,
                          style: context.textTheme.titleSmall?.copyWith(color: textColor),
                        )),
                      ],
                    ))),
      ),
    );
  }

  Text _text({dynamic text, TextStyle? style}) => Text(text.toString(), style: style ?? TextStyle(color: textColor));
}
