import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame_centipede/src/game/game.dart';

import 'components.dart';

class Mushroom extends SpriteGroupComponent<int>
    with HasGameRef<FlameCentipede>, Hitbox, Collidable {
  static const speed = 20.0;
  static final dimensions = Vector2(8, 8);

  Vector2 direction = Vector2(1, 0);

  int life = 3;

  Mushroom.atIndex(double x, double y) {
    position.x =
        x + (CentipedeBlock.dimensions.x / 2 + Mushroom.dimensions.x / 2);
    position.y =
        y + (CentipedeBlock.dimensions.y / 2 - Mushroom.dimensions.y / 2);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    addHitbox(HitboxRectangle());

    sprites = {
      3: await gameRef.loadSprite(
        'mushroom.png',
        srcSize: Vector2.all(8),
      ),
      2: await gameRef.loadSprite(
        'mushroom.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(8, 0),
      ),
      1: await gameRef.loadSprite(
        'mushroom.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(16, 0),
      ),
    };
    current = 3;

    size = dimensions;
  }

  @override
  void onCollisionEnd(Collidable other) {
    if (other is Bullet) {
      other.shouldRemove = true;
      if (life == 1) {
        shouldRemove = true;
      } else {
        life--;
        current = life;
      }
    }
  }
}
