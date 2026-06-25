import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:woc/model/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<Post>> readAllPost() async {
    final url = Uri.parse(
      "https://kindling-magnifier-late.ngrok-free.dev/readAllPost",
    );
    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception("failed to fetch post.");
    }

    final List data = jsonDecode(response.body) as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  dynamic checkHasData(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('ผิดพลาดในการอ่านข้อมูล ${snapshot.error}'));
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No data.'));
    }

    return true;
  }
}
