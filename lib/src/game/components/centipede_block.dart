import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_centipede/src/game/game.dart';

import 'components.dart';

class CentipedeBlock extends SpriteComponent
    with HasGameRef<FlameCentipede>, CollisionCallbacks {
  static const speed = 50.0;
  static final dimensions = Vector2(16, 16);

  Vector2 direction = Vector2(1, 1);

  CentipedeBlock.atIndex(int x, int y) {
    position.x = x * dimensions.x;
    position.y = y * dimensions.y;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    size = dimensions;
    sprite = await gameRef.loadSprite('centipede-section.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += direction.x * speed * dt;
    final rect = toRect();

    if ((rect.left <= 0 && direction.x < 0) ||
        (rect.right >= FlameCentipede.resolution.x && direction.x > 0)) {
      _hitSomething();
    }
  }

  void _hitSomething() {
    final rect = toRect();
    if ((direction.y < 0 && rect.top - height < 0) ||
        (direction.y > 0 &&
            rect.bottom + height > FlameCentipede.resolution.y)) {
      direction.y *= -1;
    }
    position.y += direction.y * dimensions.y;
    direction.x *= -1;
    flipHorizontally();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Bullet) {
      other.removeFromParent();
      removeFromParent();
      gameRef.add(Mushroom.atIndex(x, y));
    } else if (other is Mushroom) {
      _hitSomething();
    } else if (other is Player) {
      other.removeFromParent();
      gameRef.gameOver();
    }
  }
}
