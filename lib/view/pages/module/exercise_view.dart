import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smile/models/module.dart';
import 'package:smile/models/submodule.dart';
import 'package:smile/services/database.dart';
import 'package:smile/view/pages/module/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../theme.dart';
import 'feedback_view.dart';

class ExerciseView extends StatefulWidget{
  final SubModule subModule;
  final Module module;

  const ExerciseView( {Key? key, required this.subModule, required this.module}) : super(key: key);

  @override
  _ExerciseView createState() => _ExerciseView();

}

class _ExerciseView extends State<ExerciseView>{

  final _responseController = TextEditingController();
  final DatabaseService _database = DatabaseService();
  late AppUser user;
  late AudioPlayer audioPlayer;
  late bool isPlaying;
  late Duration duration;
  late Duration position;

  Future redirectToNextPage(String id) async{
    if (widget.subModule.hasAudio) audioPlayer.pause();
    if(_responseController.text.isNotEmpty){
      await _database.updateExerciseData(id, widget.subModule.id,
          _responseController.text, widget.subModule.name);

      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Obrigada!'),
              content: Text("Obrigada por concluir este exercício. Os dados foram enviados."),
            );
          });
    }

    widget.subModule.done = true;
    widget.module.checkLocks();
    widget.module.checkFinal(widget.subModule.id);
    _database.addSubModule(user.id, widget.subModule.id);
    widget.module.name == "Porquê a SMILE - Stop Emotional Eating?"?
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
    ) :
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackView(module: widget.module, subModule: widget.subModule))
    );
  }

  @override
  void dispose() {
    _responseController.dispose();
    if (widget.subModule.hasAudio) audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.subModule.hasAudio) {
      audioPlayer = AudioPlayer();
      isPlaying = false;
      duration = Duration.zero;
      position = Duration.zero;

      setAudio();

      //listen to states
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.PLAYING;
        });
      });

      //listen to audio duration
      audioPlayer.onDurationChanged.listen((newDuration) {
        setState((){
          duration = newDuration;
        });
      });

      //listen to audio position
      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState((){
          position = newPosition;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context)!;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: Text(widget.subModule.name, style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish',
          fontSize: 15.0,
        ),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: mainColor,
      ),
      body: Stack(
          children: [
            SingleChildScrollView(
                child :
                widget.subModule.hasAudio ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height/2-100,),
                        Text(widget.subModule.exercise!,
                        style: mainTextStyle,),
                        const SizedBox(height: 4,),
                        Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (value) async {
                            final position = Duration(seconds: value.toInt());
                            await audioPlayer.seek(position);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(position)),
                              Text(formatTime(duration - position))
                            ],
                          ),
                        ),
                        CircleAvatar(
                            radius: 35,
                            child: IconButton(
                                icon: Icon(
                                isPlaying? Icons.pause : Icons.play_arrow,
                              ),
                                iconSize: 50,
                                onPressed: () async {
                                  if (isPlaying){
                                    await audioPlayer.pause();
                                  } else {
                                    await audioPlayer.resume();
                                  }
                                }
                            )
                        )

                      ]) :
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.subModule.exercise!,
                            style: mainTextStyle,),
                        const SizedBox(height: 50,),
                        //response input
                        widget.subModule.hasTextBox ?
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  border: Border.all(color: mainColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child:  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                      controller: _responseController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Resposta'
                                      ),
                                    )
                                )
                            )
                        ) :
                        const Text(""),
                      ]
                      )
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [MaterialButton(
                    onPressed: () => redirectToNextPage(user.id),
                    color: mainColor,
                    textColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 24,
                    ) ,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                  )],
                ),
              ),
            ),
          ]
      ),

    );
  }

  String formatTime(Duration p) {
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(p.inHours);
    final minutes = twoDigits(p.inMinutes.remainder(60));
    final seconds = twoDigits(p.inSeconds.remainder(60));

    return [
      if (p.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }

  Future setAudio() async{
    final String path = 'lib/assets/audios/' + widget.subModule.exercise! +'.m4a';
    ByteData bytes = await rootBundle.load(path); //load sound from assets
    Uint8List soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await audioPlayer.playBytes(soundbytes);
    await audioPlayer.pause();
  }

}