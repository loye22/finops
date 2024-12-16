import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';

class CustomTextField extends FormField<String> {
  final TextEditingController textEditingController;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final String? hint;
  final IconData hintIcon;
  final String label;
  final int? maxChar ;

  CustomTextField({
    Key? key,
    this.selectedValue,
    this.hint = 'Tip',
    this.hintIcon = Icons.category,
    this.onChanged,
    required this.textEditingController,
    FormFieldValidator<String>? validator,
    required this.label,
    this.maxChar = 30
  }) : super(
    key: key,
    initialValue: selectedValue,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "Te rog să introduci o valoare";
      }
      return null;
    },
    builder: (FormFieldState<String> state) {
      return Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Color(0xFFE6E7E9),
                        width: .7,
                      ),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        hintIcon == Icons.category
                            ? SizedBox.shrink()
                            : Icon(hintIcon),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            maxLength: maxChar,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: hint,
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              state.didChange(value);
                              if (onChanged != null) {
                                onChanged!(value);
                              }
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
