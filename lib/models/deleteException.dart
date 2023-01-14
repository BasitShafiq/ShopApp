import 'package:flutter/material.dart';

class DeleteException implements Exception {
  final message;
  DeleteException(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
