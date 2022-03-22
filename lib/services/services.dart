import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ApiServices{

  Future<BookModel> getBook({bookName})
  async {
    String istek = bookName.replaceFirst(" ", "+");
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$istek');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return BookModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}