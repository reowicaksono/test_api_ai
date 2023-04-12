import 'dart:convert';

import 'package:ai_example/model/chat_model.dart';
import 'package:ai_example/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  Dio? _client;
  ApiProvider(this._client);

  //TODO: Implement ChatTextController

  List<TextCompletionData> messages = [];

  var state = ApiState.notFound;

  getTextCompletion(String query) async {
    addMyMessage();

    state = ApiState.loading;

    try {
      Map<String, String> rowParams = {
        "model": "text-davinci-003",
        "prompt": query,
      };

      final encodedParams = json.encode(rowParams);

      final response = await _client!.post('completions', data: encodedParams);

      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        addServerMessage(
            TextCompletionModel.fromJson(json.decode(response.data)).choices);
        state = ApiState.success;
      } else {
        // throw ServerException(message: "Image Generation Server Exception");
        state = ApiState.error;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr  ");
    } finally {}
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(i, choices[i]);
    }
  }

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = TextCompletionData(
        text: searchTextController.text, index: -999999, finish_reason: "");
    messages.insert(0, text);
  }

  TextEditingController searchTextController = TextEditingController();
}
