/*
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:record/record.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart' show experimental;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

enum recordsEnum { stop, pause, start, resume }

class RecodingAudioPlayer {
  String? path;
  bool recording = false;
  int recordDuration = 0;
  Timer? timer;
  dynamic status;
  Function(dynamic)? updateStatus;
  Function(int)? timerstatus;

  Function(bool)? recordingstatus;

  RecodingAudioPlayer(
      {this.updateStatus, this.timerstatus, this.recordingstatus});

  dynamic getCurruntStatus() {
    return status;
  }

  Future<String> getPath() async {
    if (path == null) {
     // final dir = await getExternalStorageDirectory();
      final dir = await p.getTemporaryDirectory();
      path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.mp3';
    }
    return path!;
  }

  // Its used to start Recording
  Future<void> start() async {
    try {
      if (await Record.hasPermission()) {
        await Record.start(path: await getPath());
        bool isRecording = await Record.isRecording();
        isRecording = isRecording;
        recording = true;
        recordingstatus!(recording);
        recordDuration = 0;
        status = recordsEnum.start;

        startTimer();

        if (updateStatus != null) this.updateStatus!(recordsEnum.start);
      }
    } catch (e) {
      print(e);
    }
  }

// its is used to stop recording
  Future<void> stop() async {
    timer?.cancel();
    await Record.stop();
    recording = false;
   recordingstatus!(recording);
    status = recordsEnum.stop;
    if (updateStatus != null) this.updateStatus!(recordsEnum.stop);
    //    widget.onStop();
  }

  Future<void> pause() async {
    timer?.cancel();
    recording = false;
    recordingstatus!(recording);
    await Record.pause();
    status = recordsEnum.pause;

    if (updateStatus != null) this.updateStatus!(recordsEnum.pause);
  }

  Future<void> resume() async {
    startTimer();
    await Record.resume();
    recording = true;
    recordingstatus!(recording);
    status = recordsEnum.resume;
    if (updateStatus != null) this.updateStatus!(recordsEnum.resume);
  }

  void startTimer() {
    const tick = const Duration(seconds: 1);

    timer?.cancel();

    timer = Timer.periodic(tick, (Timer t) {
      incrementSecond();
    });
  }

  void incrementSecond() {
    recordDuration++;
    if (timerstatus != null) timerstatus!(recordDuration);
  }

  void reset() {
    recordDuration = 0;
    status = recordsEnum.start;
    timer!.cancel();
  }
}
*/
