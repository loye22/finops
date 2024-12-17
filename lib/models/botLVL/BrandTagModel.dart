import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BrandTagModel {
  final String brand_tag;

  BrandTagModel({
    required this.brand_tag,
  });
}
class BrandTagDataSource extends DataGridSource {
  BrandTagDataSource({required List<BrandTagModel> brandTags}) {
    _brandTagData = brandTags
        .map<DataGridRow>((brandTag) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'brandTag',
        value: brandTag.brand_tag,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _brandTagData = [];

  @override
  List<DataGridRow> get rows => _brandTagData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList());
  }
}
