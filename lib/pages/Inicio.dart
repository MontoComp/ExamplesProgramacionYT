import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class InicioPage extends StatefulWidget {
  InicioPage({Key key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  VideoPlayerController _bigController;
  VideoPlayerController _smallController;

  ChewieController _chewieController;

  @override
  void initState() {
    _bigController =
        VideoPlayerController.asset('assets/videos/butterfly.mp4')
          ..initialize().then((_) {
            setState(() {});
          });

    _bigController.setLooping(false);
    _bigController.setVolume(0.2);
    _bigController.play();
    /////
    _smallController = VideoPlayerController.asset('assets/videos/butterfly.mp4');

    _chewieController=ChewieController(

      videoPlayerController: _smallController,
      aspectRatio: 16/9,
      autoInitialize: true,
      looping: true,

      errorBuilder: (context ,errorMessage){
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _smallController.dispose();
    _bigController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _bigController.value.initialized
                ? AspectRatio(
                    aspectRatio: _bigController.value.aspectRatio,
                    child: VideoPlayer(_bigController),
                  )
                : Container(
                    child: CircularProgressIndicator(),
                  ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text(
                  'ViajeRU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
              ),
              
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 75.0, left: 75.0),
                      borderSide: BorderSide(color: Colors.white),
                      onPressed: () {
                        //
                      },
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Text(
                          'Registro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Text(
                          'Saltar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _smallController.value.isPlaying
                ? _smallController.pause()
                : _smallController.play();
          });
        },
        child: Icon(
          _smallController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), */
    );
  }
}
