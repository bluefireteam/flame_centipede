import 'package:flame/components.dart';
import 'package:flame_centipede/src/game/game.dart';

class Background extends SpriteComponent with HasGameRef<FlameCentipede> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = FlameCentipede.resolution;

    sprite = await gameRef.loadSprite('background.png');
  }
}
