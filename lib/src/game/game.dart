import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'components/components.dart';

class FlameCentipede extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, PanDetector {
  static final resolution = Vector2(256, 240);

  FlameCentipede() {
    camera.viewport = FixedResolutionViewport(resolution);
  }

  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Background());
    _loadGame();
  }

  void _loadGame() {
    add(player = Player());

    for (var x = 0; x < 15; x++) {
      add(CentipedeBlock.atIndex(x, 0));
    }

    final random = Random();
    final grid = CentipedeBlock.dimensions;
    for (var y = grid.y * 2; y < grid.y * 12; y += grid.y * 3) {
      for (var x = 0.0; x < grid.x * 14; x += grid.x * 3) {
        add(Mushroom.atIndex(x + (random.nextDouble() * grid.x * 2), y));
      }
    }
  }

  @override
  void onPanStart(_) {
    player.beginFiring();
  }

  @override
  void onPanEnd(_) {
    player.stopFiring();
  }

  @override
  void onPanCancel() {
    player.stopFiring();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }

  void gameOver() {
    removeWhere((element) => element is! Background);
    _loadGame();
  }
}
