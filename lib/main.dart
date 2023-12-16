import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kyu_mail/mail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/sign_in_button.dart';

/// The scopes required by this application.

void main() {
  runApp(
    const GetMaterialApp(
      showSemanticsDebugger: false,
      title: 'Google Sign In',
      home: mail_page(),
    ),
  );
}

/// The SignInDemo app.
