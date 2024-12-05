import 'package:finops/models/staticVar.dart';
import 'package:finops/widgets/CustomDropdown.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:flutter/material.dart';

class AddCustomerDialog extends StatefulWidget {
  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String? s1;
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform your submission logic here
      print("Form submitted successfully!");

    } else {
      // Form is invalid, show errors
      print("Form is invalid!");
    }
  }
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: staticVar.fullWidth(context) * .3,
        height: staticVar.fullhigth(context) * .8,
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(20)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Add new customer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: staticVar.fullWidth(context),
                  color: Color(0xfff8f8fa),
                  child: Column(
                    children: [
                      Text(
                        "Add new customerx",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CustomDropdown(
                                selectedValue: s1,
                                onChanged: (s) {

                                  setState(() {
                                    s1 = s;
                                    print(s1);
                                  });

                                },
                                lable: 'label1',
                                items: ['a', 'b', 'c'],
                                textEditingController: t1,
                                onAddNewItemPressed: () {}),
                            SizedBox(
                              width: 10,
                            ),
                            CustomDropdown(
                                lable: 'label3',
                                items: ['a', 'b', 'c'],
                                textEditingController: t2,
                                onAddNewItemPressed: () {}),
                          ],
                        ),
                      ) ,
                      Row(
                        children: [
                          CustomTextField(textEditingController: TextEditingController(), label: "label 4 "),
                          CustomTextField(textEditingController: TextEditingController(), label: "label 4 ") ,
                        ],
                      ) ,
                    ],
                  ),
                ),
              ),


              SizedBox(height: 16),
              // Add any form fields or content here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        title: "Create",
                        backgroundColor: staticVar.themeColor,
                        textColor: Colors.white,
                        onPressed: _submitForm),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        title: "Cancel",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
