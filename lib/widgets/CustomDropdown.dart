import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends FormField<String> {
  final List<String> items;
  final String? hint;
  final TextEditingController textEditingController;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final IconData hintIcon;
  final VoidCallback onAddNewItemPressed;
  final String lable ;

  CustomDropdown({
    Key? key,
    this.selectedValue,
    required this.items,
    this.hint = 'Tip',
    this.hintIcon = Icons.category,
    this.onChanged,
    required this.textEditingController,
    required this.onAddNewItemPressed,
    FormFieldValidator<String>? validator,
    required this.lable
  }) : super(
          key: key,
          initialValue: selectedValue,
          validator: (value) {
            if (value == 'add_new') {
              return 'This value cannot be selected.';
            }
            if (value == null || value.isEmpty) {
              return "Te rog să selectezi o valoare";
            }
            return null;
          },
          builder: (FormFieldState<String> state) {
            return Flexible(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(lable,style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold), ),
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
                        child: DropdownButtonHideUnderline(
                          child: Builder(builder: (context) {
                            double screenWidth = MediaQuery.of(context).size.width;

                            return DropdownButton2<String>(
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(color: Colors.white),
                                maxHeight: 200,
                                width: screenWidth * 0.4,
                              ),
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  hintIcon == Icons.category ? SizedBox.shrink() :  Icon(hintIcon),
                                  SizedBox(width: 8),
                                  Text(
                                    hint!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'add_new',
                                  child: TextButton.icon(
                                    onPressed: onAddNewItemPressed,
                                    icon:  Icon(Icons.edit,
                                        size: 18, color: staticVar.themeColor ),
                                    label:  Text(
                                      'Add New',
                                      style: TextStyle(color: staticVar.themeColor),
                                    ),
                                  ),
                                ),
                                ...items.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                              ],
                              value: selectedValue,
                              onChanged: (value) {
                                state.didChange(value);
                                if (onChanged != null) {
                                  onChanged!(value);
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: screenWidth * 0.4, // Set a reasonable width
                              ),

                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: textEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 70,
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      hintText: "Caută un articol...",
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  textEditingController.clear();
                                }
                              },
                            );
                          }),
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
            );
          },
        );
}
