import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:manifest/core/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:get/get.dart';

class AudioRecorderController extends GetxController {
  /// Voice Recorder
  bool isPlayingRecord = false;
  Future<void> requestPermissions() async {
    PermissionStatus microphone = await Permission.microphone.status;
    PermissionStatus storage = await Permission.storage.status;
    if (!microphone.isGranted) {
      microphone = await Permission.microphone.request();
    }
    if (!storage.isGranted) {
      storage = await Permission.storage.request();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    requestPermissions();
    super.onInit();
  }

  int recordDuration = 0;
  Timer? _timer;
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }

  Record record = Record();
  RxBool recordingStarted = false.obs;
  RxBool recordingPlaying = false.obs;
  String? audioFilePath;
  String? audioFile;
  RxBool isPlaying = false.obs;

  _writeFileToStorage() async {
    File audioFileStorage = File(audioFile!);
    Uint8List bytes = await audioFileStorage.readAsBytes();
    audioFileStorage.writeAsBytes(bytes);
    LogUtil.i("saved to Storage: ${audioFileStorage.path} ");
  }

  /// get path from directory
  getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return path;
  }

  startRecording() async {
    recordingStarted = true.obs;
    update();
    // * get application documents directory path
    String path = await getPath();

    // * @documented by: alok singh
    // * name the audio file
    audioFilePath = '$path/${DateTime.now().toString()}.mp4';

    // * if recording permission is granted
    if (await record.hasPermission()) {
      LogUtil.v(' file path: $audioFilePath  directory path: $path');

      // * start recording
      await record.start(
        path: audioFilePath,
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        samplingRate: 44100,
      );

      // * start the recording timer
      _startTimer();

      // * Listen to recorder states [RecordState].
      record.onStateChanged();

      // * store the audio file
      audioFile = audioFilePath;
      await _writeFileToStorage();
    } else {
      Permission.microphone.request();
      startRecording();
    }
  }

  stopRecording() async {
    _timer?.cancel();
    recordDuration = 0;
    recordingStarted = false.obs;
    await record.stop();
    update();
  }
}
