import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    bubbles.forEach((it) => it.draw(canvas, size));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color color;
  double direction;
  double speed;
  double radius;
  double x;
  double y;

  Bubble(Color color, double maxBubbleSize) {
    this.color = color;
    this.direction = Random().nextDouble() * 360.0;
    this.speed = 1.5;
    this.radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);
    randomlyChangeDirectionIfEdgeReached(canvasSize);
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if(x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if(y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    var a = 180 - (direction + 90);
    direction > 0 && direction < 100
        ? x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);

    direction > 90 && direction < 270
        ? y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if(x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360.0;
    }
  }
}