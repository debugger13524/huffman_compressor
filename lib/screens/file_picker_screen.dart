import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:huffmanapp/services/encode_text.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class FilePickerScreen extends StatefulWidget {
  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  FilePickerResult result;
  String fileName;
  String encodedText = '';
  String normalText='Please upload a file';
  String freqTable = '';
  bool _accessPermission = false;
  var downloadsPath;

  Future<Directory> _getDownloadsPath =
      DownloadsPathProvider.downloadsDirectory;
  Future _writeToFile(String text) async {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      setState(() {
        _accessPermission = true;
      });
    }
    print("Inside _writeToFile");
    if (_accessPermission == false) {
      print("NULL");
      return null;
    }
    final downloadsDir = await _getDownloadsPath;
    downloadsPath = downloadsDir.path;

    print("External Path===>>>> $downloadsPath");
    final file = File('$downloadsPath/${fileName.split('.')[0]}_enoded.txt');

    file.writeAsString('$text');
  }

  Future<File> _pickFile() async {
    try {
      result = await FilePicker.platform.pickFiles();

      setState(() {
        fileName = result.files[0].name;
      });

      if (result != null) {
        File file = File(result.files.single.path);
        String content = await file.readAsString();
        print(content);
        setState(() {
          normalText=content;
        });

        EncodeText encodeText = EncodeText(content);
         encodeText.calculateHuffmanCode();


        print("\n${   encodeText.getCharactersCodes()}");

        print("\n${  encodeText.getResultText()}");

        await _writeToFile(encodeText.getResultText())
            .then((value) => showAlertDialog(context));

        setState(() {
          freqTable = encodeText.getCharactersCodes();
          encodedText = encodeText.getResultText();
        });

        print('\n\n\n\n File Name: ${result.files[0].name} \n');
        return file;
      } else {
        print('Cancelled');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 10,
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Huffman Compressor',
          style: GoogleFonts.poppins(
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  fileName == null ? '' : fileName,
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      onPressed: _pickFile,
                      color: Colors.blueAccent,
                      child: Text(
                        'Upload',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                  child: Column(
                    children: [
                      Text(
                        normalText == 'Please upload a file'
                            ? 'Please upload a file'
                            : 'Text:',
                        style: GoogleFonts.roboto(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(normalText== 'Please upload a file'?'':normalText,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                  child: Column(
                    children: [
                      Text(
                        encodedText == ''
                            ? ''
                            : 'Encoded Text:',
                        style: GoogleFonts.roboto(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(encodedText,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                          ),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("File Encoded"),
      content: Text("Encoded file has been saved to\n\nPath:$downloadsPath"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
