// addOperation.dart
import 'package:file_picker/file_picker.dart';
import 'package:finops/models/staticVar.dart';
import 'package:finops/screens/botLVL/DocumentTypeUI.dart';
import 'package:finops/widgets/DateTextField.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../provider/botLVL/DocumentClassProvider.dart';
import '../../provider/botLVL/DocumentProvider.dart';
import '../../provider/midLVL/EntityDataProvider.dart';
import '../../widgets/CustomDropdown.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/customButton.dart';
import '../botLVL/DocumentClassUI.dart';

class addDocumentsScreen extends StatefulWidget {
  const addDocumentsScreen({super.key});

  @override
  State<addDocumentsScreen> createState() => _addDocumentsScreenState();
}

class _addDocumentsScreenState extends State<addDocumentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchController2 = TextEditingController();
  final TextEditingController searchController3 = TextEditingController();
  final TextEditingController searchController4 = TextEditingController();
  final TextEditingController documentNameController = TextEditingController();
  final TextEditingController documentNumberController =
      TextEditingController();
  final TextEditingController documentSeriesController =
      TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endsDate = TextEditingController();

  String? selectedDocumentClass;
  String? selectedDocumentType;
  String? selectedDocumentCategory;
  String? selectedBeneficiar;
  String? selectedPartener;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final documentName = documentNameController.text.trim();
      final documentClass = selectedDocumentClass;
      final documentType = selectedDocumentType;
      final documentCategory = selectedDocumentCategory;

      if (documentClass == null ||
          documentType == null ||
          documentCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select all required fields.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      // Handle form submission logic
      print('Document Name: $documentName');
      print('Document Class: $documentClass');
      print('Document Type: $documentType');
      print('Document Category: $documentCategory');
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentClassProvider = Provider.of<DocumentClassProvider>(context);
    final documentTypeProvider = Provider.of<DocumentProvider>(context);
    final EntityDataProvider = Provider.of<EntityProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdown(
                      items: documentClassProvider.documentClassList
                          .map((e) => e.document_class)
                          .toList(),
                      textEditingController: searchController,
                      hint: 'Select Document Class',
                      lable: "Document Class",
                      selectedValue: selectedDocumentClass,
                      onChanged: (value) {
                        setState(() {
                          selectedDocumentClass = value;
                        });
                      },
                      onAddNewItemPressed: () {
                        showVehicleBrandDialog(context);
                      },
                    ),
                    CustomDropdown(
                      items: documentTypeProvider.documentClassList
                          .map((e) => e.document_type)
                          .toList(),
                      textEditingController: searchController2,
                      hint: 'Vă rugăm să selectați tipul documentului.',
                      lable: "Tip Document",
                      selectedValue: selectedDocumentType,
                      onChanged: (value) {
                        setState(() {
                          selectedDocumentType = value;
                        });
                      },
                      onAddNewItemPressed: () {
                        showDocumentTypeDialog(context);
                      },
                    ),
                    CustomTextField(
                      textEditingController: documentNameController,
                      label: "Nume Document",
                      hint: "Vă rugăm să introduceți numele documentului.",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vă rugăm să introduceți numele documentului!!';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      optional: true,
                      textEditingController: documentNumberController,
                      label: "Numar Document",
                      hint: "Vă rugăm să introduceți numar documentului.",
                      validator: (value) {},
                    ),
                    CustomTextField(
                      optional: true,
                      textEditingController: documentSeriesController,
                      label: "Serie Document",
                      hint: "Vă rugăm să introduceți seria documentului",
                      validator: (value) {},
                    ),
                    CustomDropdown(
                      items: EntityDataProvider.entityList
                          .map((e) => e.entity_id)
                          .toList(),
                      textEditingController: searchController3,
                      hint: 'Vă rugăm să selectați ID-ul beneficiarului.',
                      lable: "Beneficiar",
                      selectedValue: selectedBeneficiar,
                      onChanged: (value) {
                        setState(() {
                          selectedBeneficiar = value;
                        });
                      },
                      onAddNewItemPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: Text(
                              "comming soon ",
                              style: TextStyle(color: Colors.white),
                            ));
                          },
                        );
                      },
                    ),
                    CustomDropdown(
                      items: EntityDataProvider.entityList
                          .map((e) => e.entity_id)
                          .toList(),
                      textEditingController: searchController4,
                      hint: "Vă rugăm să introduceți ID-ul partenerului. ",
                      lable: "Partener",
                      selectedValue: selectedPartener,
                      onChanged: (value) {
                        setState(() {
                          selectedPartener = value;
                        });
                      },
                      onAddNewItemPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: Text(
                              "comming soon ",
                              style: TextStyle(color: Colors.white),
                            ));
                          },
                        );
                      },
                    ),
                    DateTextField(
                        textEditingController: startDate,
                        label: "Data Inceput"),
                    DateTextField(
                        textEditingController: endsDate,
                        label: "Data Sfarsit"),
                    SizedBox(height: 400),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FileDisplayWidget(
                  onFileUploaded: (file) {
                    print('File uploaded: ${file.name}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showVehicleBrandDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddDocumentClassDialog();
      },
    );
  }

  void showDocumentTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddDocumentTypeDialog(); // Dialog to add a new document type
      },
    );
  }
}

// class addDocumentsScreen extends StatefulWidget {
//   const addDocumentsScreen({super.key});
//
//   @override
//   State<addDocumentsScreen> createState() => _addDocumentsScreenState();
// }
//
// class _addDocumentsScreenState extends State<addDocumentsScreen> {
//   final DataGridController _dataGridController = DataGridController();
//   TextEditingController searchController = TextEditingController();
//   String? selectedDocumentClass;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final documentClassProvider = Provider.of<DocumentClassProvider>(context);
//
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Row(
//         children: [
//           Expanded(
//               child: Container(
//             decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//             child:Column(
//              children: [
//                CustomDropdown(
//                  items: documentClassProvider.documentClassList
//                      .map((e) => e.document_class)
//                      .toList(),
//                  textEditingController: searchController,
//                  hint: 'Selectați clasa Document',
//                  lable: "Clasa Document",
//                  selectedValue: selectedDocumentClass,
//                  onChanged: (value) {
//                    setState(() {
//                      selectedDocumentClass = value;
//                    });
//                  },
//                  onAddNewItemPressed: ()  {
//                    // Handle add new vehicle brand
//                    showVehicleBrandDialog(context);
//
//                  },
//                ),
//              ],
//             ),
//           )),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: FileDisplayWidget(
//                 onFileUploaded: (file) {
//                   // Handle the uploaded file
//                   print('File uploaded: ${file.name}');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   void showVehicleBrandDialog(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AddDocumentClassDialog();
//       },
//     );
//   }
// }

class FileDisplayWidget extends StatefulWidget {
  final Function(PlatformFile) onFileUploaded;

  const FileDisplayWidget({Key? key, required this.onFileUploaded})
      : super(key: key);

  @override
  _FileDisplayWidgetState createState() => _FileDisplayWidgetState();
}

class _FileDisplayWidgetState extends State<FileDisplayWidget> {
  PlatformFile? _selectedFile;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    setState(() => _isLoading = true);

    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('new 2')));
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() => _selectedFile = result.files.first);
        widget.onFileUploaded(_selectedFile!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildFilePreview() {
    if (_selectedFile == null) {
      return const Center(
        child: Text(
          'No file selected',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    if (_selectedFile!.extension == 'pdf') {
      return SfPdfViewer.memory(
        _selectedFile!.bytes!,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      );
    } else {
      return Image.memory(
        _selectedFile!.bytes!,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // File Preview Section
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildFilePreview(),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Upload Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _pickFile,
            icon: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.upload, color: Colors.white),
            label: Text(
              _isLoading ? 'Uploading...' : 'Upload File',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: staticVar.themeColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
