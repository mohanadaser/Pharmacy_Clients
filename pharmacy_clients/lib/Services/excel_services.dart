import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as path_provider;

class ExcelServices {
  static Future<void> exportDataToExcel() async {
    List<QueryDocumentSnapshot> data = [];
    // Retrieve the data from Firebase
    final QuerySnapshot q = await FirebaseFirestore.instance
        .collectionGroup("invoices")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        //.collection('pharmacists')
        //.doc(FirebaseAuth.instance.currentUser?.uid)
        //.collection('clients')
        //.doc()
        //.collection('invoices')
        .get();

    data.addAll(q.docs);
    log('${data.length}');
    // Create an Excel file
    final Excel excel = Excel.createExcel();
    final Sheet sheet = excel.sheets['Sheet1']!;

    // Write the data to the Excel file
    for (int i = 0; i < data.length; i++) {
      final QueryDocumentSnapshot<Object?> row = data[i];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = row['name'];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = row['type'];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = row['date'];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = row['cureAmount'];
    }

    // Save the Excel file to the device's storage
    final directory = await path_provider.getExternalStorageDirectory();
    final path = directory?.path;

    // Create a new file in the directory
    final file = File('$path/data.xlsx');

    // Write the Excel file to the new file
    await file.writeAsBytes(excel.encode()!);
    // String filePath = await _getFilePath();
    // excel.save(fileName: filePath);
    Get.snackbar(
      'نجاح',
      'تم تحميل الملف بنجاح',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    log(file.path);
  }

  // static Future<String> _getFilePath() async {
  //   final Directory directory =
  //       await path_provider.getApplicationDocumentsDirectory();
  //   return '${directory.path}/data.xlsx';
  // }
}
