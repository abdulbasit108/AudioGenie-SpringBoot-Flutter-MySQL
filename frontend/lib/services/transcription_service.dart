// ignore_for_file: use_build_context_synchronously


import 'dart:convert';

import 'package:audio_genie/models/transcription.dart';
import 'package:audio_genie/utils/constants.dart';
import 'package:audio_genie/utils/error_handling.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';



class TranscriptionService {

  Future<Transcription?> transcribeAudio({
    required BuildContext context,
    required String audioLink,
  }) async {
    Transcription? transcription;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('Authorization');

      http.Response res = await http.post(
        Uri.parse('$uri/transcription/generate'),
        body: jsonEncode({'audioLink': audioLink}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token!,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          transcription = Transcription.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return transcription;
  }

  Future<List<Transcription>> fetchAllTranscriptions({
    required BuildContext context,
  }) async {
    List<Transcription> transcriptionList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('Authorization');

      http.Response res = await http.get(
        Uri.parse('$uri/transcription/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token!,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            transcriptionList.add(
              Transcription.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return transcriptionList;
  }

  }
