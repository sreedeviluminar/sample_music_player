import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: AudioList(),
      ),
    );
  }
}

class AudioList extends StatefulWidget {
  @override
  _AudioListState createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> audioFiles = [];

  @override
  void initState() {
    super.initState();
    getAudioFiles();
  }

  Future<void> getAudioFiles() async {
    Directory? directory = await getExternalStorageDirectory();
    List<FileSystemEntity>? files = directory?.listSync(recursive: true);
    for (FileSystemEntity file in files!) {
      if (file.path.endsWith('.mp3')) {
        audioFiles.add(file.path);
      }
    }
    setState(() {});
  }

  Future<void> playAudioFromPath(String path) async {
    await audioPlayer.play(path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: audioFiles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(audioFiles[index]),
                onTap: () {
                  playAudioFromPath(audioFiles[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
