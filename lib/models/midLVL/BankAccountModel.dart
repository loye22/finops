import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BankAccountModel {
  final String bankAccountIban;
  final String userEmail;
  final DateTime userTimestamp;
  final String section1;
  final String bankName;
  final String ownerId;
  final String currency;
  final String administration; // this must be bool
  final String active;         // this must be bool

  BankAccountModel({
    required this.bankAccountIban,
    required this.userEmail,
    required this.userTimestamp,
    required this.section1,
    required this.bankName,
    required this.ownerId,
    required this.currency,
    required this.administration,
    required this.active,
  });
}


class BankAccountDataSource extends DataGridSource {
  BankAccountDataSource({required List<BankAccountModel> bankAccounts}) {
    _bankAccountData = bankAccounts.map<DataGridRow>((bankAccount) {
      return DataGridRow(cells: [
        DataGridCell<String>(
          columnName: 'bank_account_iban',
          value: bankAccount.bankAccountIban,
        ),
        DataGridCell<String>(
          columnName: 'user_email',
          value: bankAccount.userEmail,
        ),
        DataGridCell<DateTime>(
          columnName: 'user_timestamp',
          value: bankAccount.userTimestamp,
        ),
        DataGridCell<String>(
          columnName: 'section_1',
          value: bankAccount.section1,
        ),
        DataGridCell<String>(
          columnName: 'bank_name',
          value: bankAccount.bankName,
        ),
        DataGridCell<String>(
          columnName: 'owner_id',
          value: bankAccount.ownerId,
        ),
        DataGridCell<String>(
          columnName: 'currency',
          value: bankAccount.currency,
        ),
        DataGridCell<String>(
          columnName: 'administration',
          value: bankAccount.administration,
        ),
        DataGridCell<String>(
          columnName: 'active',
          value: bankAccount.active,
        ),
      ]);
    }).toList();
  }

  List<DataGridRow> _bankAccountData = [];

  @override
  List<DataGridRow> get rows => _bankAccountData;

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
            style: TextStyle(
              fontWeight: dataGridCell.columnName == 'active' &&
                  dataGridCell.value == true
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: dataGridCell.columnName == 'active' &&
                  dataGridCell.value == true
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
