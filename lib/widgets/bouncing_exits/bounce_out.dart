/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 Sjoerd van den Berg
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

///Used by [BounceOut] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class BounceOutAnimation extends AnimationDefinition {
  BounceOutAnimation({
    AnimationPreferences preferences = const AnimationPreferences(
      duration: Duration(milliseconds: 750),
    ),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform.scale(
          child: child,
          scale: animator.get("scale")!.value,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    return {
      "opacity": TweenList<double>(
        [
          TweenPercentage(percent: 55, value: 1.0),
          TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
      "scale": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 1.0),
          TweenPercentage(percent: 20, value: 0.9),
          TweenPercentage(percent: 50, value: 1.1),
          TweenPercentage(percent: 55, value: 1.1),
          TweenPercentage(percent: 100, value: 0.3),
        ],
      ),
    };
  }
}

/// Example of using BounceOut:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return BounceOut(child: Text('Bounce'));
///   }
///
/// }
/// ```
class BounceOut extends AnimatorWidget {
  BounceOut({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: BounceOutAnimation(preferences: preferences));
}
