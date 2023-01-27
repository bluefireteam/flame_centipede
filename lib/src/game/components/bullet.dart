import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_centipede/src/game/game.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef<FlameCentipede>, CollisionCallbacks {
  static const speed = -200.0;
  static final dimensions = Vector2(4, 4);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    size = dimensions;
    animation = await gameRef.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.2,
        textureSize: Vector2.all(4),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += speed * dt;

    if (toRect().bottom <= 0) {
      removeFromParent();
    }
  }
}
