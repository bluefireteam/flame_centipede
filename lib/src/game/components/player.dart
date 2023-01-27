import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_centipede/src/game/game.dart';
import 'package:flutter/services.dart';

import 'components.dart';

class Player extends SpriteComponent
    with HasGameRef<FlameCentipede>, KeyboardHandler, CollisionCallbacks {
  static const speed = 50.0;

  Vector2 direction = Vector2.zero();

  late Timer _shootTimer;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    width = 8;
    height = 16;

    x = (FlameCentipede.resolution.x / 2) - width / 2;
    y = FlameCentipede.resolution.y - height;
    add(RectangleHitbox.relative(Vector2(0.8, 0.8), parentSize: size));

    sprite = await gameRef.loadSprite('player.png');

    _shootTimer = Timer(0.5, onTick: _shoot, repeat: true);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shootTimer.update(dt);

    final newPosition = position + direction * speed * dt;
    final rect = newPosition.toPositionedRect(size);

    if (rect.left > 0 && rect.right < FlameCentipede.resolution.x) {
      position.x = newPosition.x;
    }
    if (rect.top > 0 && rect.bottom < FlameCentipede.resolution.y) {
      position.y = newPosition.y;
    }
  }

  void _shoot() {
    gameRef.add(
      Bullet()
        ..x = x + (width / 2 - Bullet.dimensions.x / 2)
        ..y = y - Bullet.dimensions.y,
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent key, keys) {
    final isDown = key is RawKeyDownEvent;

    if (key.logicalKey == LogicalKeyboardKey.keyA) {
      direction.x = isDown ? -1 : 0;
      return true;
    }
    if (key.logicalKey == LogicalKeyboardKey.keyD) {
      direction.x = isDown ? 1 : 0;
      return true;
    }
    if (key.logicalKey == LogicalKeyboardKey.keyW) {
      direction.y = isDown ? -1 : 0;
      return true;
    }
    if (key.logicalKey == LogicalKeyboardKey.keyS) {
      direction.y = isDown ? 1 : 0;
      return true;
    }

    if (key.logicalKey == LogicalKeyboardKey.space && isDown) {
      _shoot();
    }

    return false;
  }

  void beginFiring() {
    _shootTimer.start();
  }

  void stopFiring() {
    _shootTimer.stop();
  }

  void move(Vector2 delta) {
    position += delta;
  }
}
