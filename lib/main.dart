import 'package:flame/game.dart';
import 'package:flame_centipede/src/game/game.dart';
import 'package:flutter/material.dart';

class CentipedeGame extends StatefulWidget {
  @override
  State<CentipedeGame> createState() => _CentipedeGameState();
}

class _CentipedeGameState extends State<CentipedeGame> {
  FlameCentipede? _game;

  @override
  Widget build(BuildContext context) {
    if (_game != null) {
      return Stack(
        children: [
          GameWidget(
            game: FlameCentipede(),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _game = FlameCentipede();
                });
              },
              icon: Icon(
                Icons.replay,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '''
                Welcome to Flame Centipede!

                Keyboard controls:
                W, S, D, A to move SPACE to shoot

                Gesture controls:
                Drag the screen to move and auto shoot
                ''',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _game = FlameCentipede();
              });
            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: CentipedeGame(),
      ),
    ),
  );
}
