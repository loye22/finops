// addOperation.dart
import 'package:file_picker/file_picker.dart';
import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class addOperation extends StatefulWidget {
  const addOperation({super.key});

  @override
  State<addOperation> createState() => _addOperationState();
}

class _addOperationState extends State<addOperation> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body:  Row(
        children: [
          Expanded(child: Container( decoration: BoxDecoration(border: Border.all(color: Colors.black)),)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FileDisplayWidget(
                onFileUploaded: (file) {
                  // Handle the uploaded file
                  print('File uploaded: ${file.name}');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class FileDisplayWidget extends StatefulWidget {
  final Function(PlatformFile) onFileUploaded;

  const FileDisplayWidget({Key? key, required this.onFileUploaded}) : super(key: key);

  @override
  _FileDisplayWidgetState createState() => _FileDisplayWidgetState();
}

class _FileDisplayWidgetState extends State<FileDisplayWidget> {
  PlatformFile? _selectedFile;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    setState(() => _isLoading = true);

    try {
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
                : const Icon(Icons.upload , color: Colors.white),
            label: Text(_isLoading ? 'Uploading...' : 'Upload File' , style: TextStyle(color: Colors.white),),
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