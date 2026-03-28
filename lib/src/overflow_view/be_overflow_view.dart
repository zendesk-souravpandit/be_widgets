// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';

import 'be_value_layout_builder.dart';
import 'render_be_overflow_view.dart';

export 'be_value_layout_builder.dart' show BeBoxValueConstraints;
export 'render_be_overflow_view.dart'
    show BeOverflowViewLayoutBehavior, BeOverflowViewParentData;

/// Signature for a builder that creates an overflow indicator when there is not
/// enough space to display all children of a [BeOverflowView].
typedef BeOverflowIndicatorBuilder = Widget Function(
  BuildContext context,
  int remainingItemCount,
);

/// A widget that displays its children in a one-dimensional array until there
/// is no more room. If all children don't fit in the available space, it
/// displays an indicator at the end.
///
/// Example:
/// ```dart
/// BeOverflowView(
///   spacing: 8,
///   builder: (context, count) => Text('+$count more'),
///   children: [
///     Chip(label: Text('Tag 1')),
///     Chip(label: Text('Tag 2')),
///     Chip(label: Text('Tag 3')),
///   ],
/// )
/// ```
class BeOverflowView extends MultiChildRenderObjectWidget {
  /// Creates a [BeOverflowView] where all children have the same size as the
  /// first child.
  ///
  /// The [spacing] argument must be finite.
  BeOverflowView({
    super.key,
    required BeOverflowIndicatorBuilder builder,
    this.direction = Axis.horizontal,
    required List<Widget> children,
    this.spacing = 0,
    this.reverse = false,
  })  : assert(spacing.isFinite),
        _layoutBehavior = BeOverflowViewLayoutBehavior.fixed,
        super(
          children: [
            ...children,
            BeValueLayoutBuilder<int>(
              builder: (context, constraints) {
                return builder(context, constraints.value);
              },
            ),
          ],
        );

  /// Creates a flexible [BeOverflowView] where each child can have its own size.
  ///
  /// The [spacing] argument must be finite.
  BeOverflowView.flexible({
    super.key,
    required BeOverflowIndicatorBuilder builder,
    this.direction = Axis.horizontal,
    required List<Widget> children,
    this.spacing = 0,
    this.reverse = false,
  })  : assert(spacing.isFinite),
        _layoutBehavior = BeOverflowViewLayoutBehavior.flexible,
        super(
          children: [
            ...children,
            BeValueLayoutBuilder<int>(
              builder: (context, constraints) {
                return builder(context, constraints.value);
              },
            ),
          ],
        );

  /// The direction to use as the main axis.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another as in a [Row].
  final Axis direction;

  /// The amount of space between successive children.
  final double spacing;

  /// Whether to display children in reverse order.
  ///
  /// When true, the last children are displayed first, and overflow happens
  /// from the beginning instead of the end.
  final bool reverse;

  final BeOverflowViewLayoutBehavior _layoutBehavior;

  @override
  _BeOverflowViewElement createElement() {
    return _BeOverflowViewElement(this);
  }

  @override
  RenderBeOverflowView createRenderObject(BuildContext context) {
    return RenderBeOverflowView(
      direction: direction,
      spacing: spacing,
      layoutBehavior: _layoutBehavior,
      reverse: reverse,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderBeOverflowView renderObject,
  ) {
    renderObject
      ..direction = direction
      ..spacing = spacing
      ..layoutBehavior = _layoutBehavior
      ..reverse = reverse;
  }
}

class _BeOverflowViewElement extends MultiChildRenderObjectElement {
  _BeOverflowViewElement(BeOverflowView super.widget);

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    for (final element in children) {
      if (element.renderObject?.isOnstageInOverflowView == true) {
        visitor(element);
      }
    }
  }
}
