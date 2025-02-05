import 'package:flutter/material.dart';

class DateTextField extends FormField<String> {
  final TextEditingController textEditingController;
  final String label;
  final String? hint;
  final IconData hintIcon;
  final ValueChanged<String?>? onChanged;

  DateTextField({
    Key? key,
    required this.textEditingController,
    required this.label,
    this.hint = 'Alege o dată',
    this.hintIcon = Icons.calendar_today,
    this.onChanged,
    String? selectedValue,
  }) : super(
    key: key,
    initialValue: selectedValue,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "Vă rugăm să selectați o dată";
      }
      return null;
    },
    builder: (FormFieldState<String> state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: state.context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    String formattedDate =
                        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                    textEditingController.text = formattedDate;
                    state.didChange(selectedDate.millisecondsSinceEpoch.toString() /*formattedDate*/);
                    if (onChanged != null) {
                      onChanged!(selectedDate.millisecondsSinceEpoch.toString()/*formattedDate*/);
                    }
                  }
                },
                child: AbsorbPointer( // Make the TextField non-editable
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: hint,
                      suffixIcon: Icon(hintIcon),
                      border: OutlineInputBorder(),
                    ),
                  ),
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
        ),
      );
    },
  );
}
