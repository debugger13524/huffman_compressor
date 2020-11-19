import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class FilePickerScreen extends StatefulWidget {
  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {


  FilePickerResult result;
  String fileName;

 Future<File> _pickFile()async{
 try {
   result = await FilePicker.platform.pickFiles();

   setState(() {
     fileName=result.files[0].name;
   });

   if (result != null) {
     File file = File(result.files.single.path);

     print('\n\n\n\n File Name: ${result.files[0].name} \n');
     return file;
   } else {
     print('Cancelled');
     return null;
   }
 }catch(e)
   {
     print(e);
     return null;
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Huffman Compressor'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
             Text(fileName==null?'':fileName),
              RaisedButton(
                onPressed: _pickFile,
                child: Text('Pick'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
