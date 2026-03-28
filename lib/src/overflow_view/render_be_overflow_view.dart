// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import 'be_value_layout_builder.dart';

/// Parent data for [RenderBeOverflowView].
class BeOverflowViewParentData extends ContainerBoxParentData<RenderBox> {
  /// Whether this child is offstage (not visible).
  bool? offstage;
}

/// Layout behavior for [BeOverflowView].
enum BeOverflowViewLayoutBehavior {
  /// All children have the same size as the first child.
  fixed,

  /// Each child can have its own size.
  flexible,
}

/// RenderObject for [BeOverflowView].
class RenderBeOverflowView extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, BeOverflowViewParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, BeOverflowViewParentData> {
  RenderBeOverflowView({
    List<RenderBox>? children,
    required Axis direction,
    required double spacing,
    required BeOverflowViewLayoutBehavior layoutBehavior,
    required bool reverse,
  })  : assert(spacing.isFinite),
        _direction = direction,
        _spacing = spacing,
        _layoutBehavior = layoutBehavior,
        _reverse = reverse {
    addAll(children);
  }

  Axis _direction;
  Axis get direction => _direction;
  set direction(Axis value) {
    if (_direction != value) {
      _direction = value;
      markNeedsLayout();
    }
  }

  double _spacing;
  double get spacing => _spacing;
  set spacing(double value) {
    assert(value.isFinite);
    if (_spacing != value) {
      _spacing = value;
      markNeedsLayout();
    }
  }

  BeOverflowViewLayoutBehavior _layoutBehavior;
  BeOverflowViewLayoutBehavior get layoutBehavior => _layoutBehavior;
  set layoutBehavior(BeOverflowViewLayoutBehavior value) {
    if (_layoutBehavior != value) {
      _layoutBehavior = value;
      markNeedsLayout();
    }
  }

  bool _reverse;
  bool get reverse => _reverse;
  set reverse(bool value) {
    if (_reverse != value) {
      _reverse = value;
      markNeedsLayout();
    }
  }

  bool get _isHorizontal => _direction == Axis.horizontal;

  bool _hasOverflow = false;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BeOverflowViewParentData) {
      child.parentData = BeOverflowViewParentData();
    }
  }

  double _getMainSize(RenderBox child) {
    return _isHorizontal ? child.size.width : child.size.height;
  }

  double _getCrossSize(RenderBox child) {
    return _isHorizontal ? child.size.height : child.size.width;
  }

  Offset _getOffset(double mainOffset, double crossOffset) {
    return _isHorizontal
        ? Offset(mainOffset, crossOffset)
        : Offset(crossOffset, mainOffset);
  }

  @override
  void performLayout() {
    _hasOverflow = false;

    if (firstChild == null) {
      size = constraints.smallest;
      return;
    }

    _resetOffstage();

    if (_layoutBehavior == BeOverflowViewLayoutBehavior.fixed) {
      _performFixedLayout();
    } else {
      _performFlexibleLayout();
    }
  }

  void _resetOffstage() {
    visitChildren((child) {
      final parentData = child.parentData as BeOverflowViewParentData;
      parentData.offstage = null;
    });
  }

  void _performFixedLayout() {
    final double maxExtent =
        _isHorizontal ? constraints.maxWidth : constraints.maxHeight;
    final double maxCrossExtent =
        _isHorizontal ? constraints.maxHeight : constraints.maxWidth;

    // Layout first child to get reference size
    final RenderBox firstRegularChild = firstChild!;
    final BoxConstraints childConstraints = BoxConstraints.loose(
      _isHorizontal
          ? Size(double.infinity, maxCrossExtent)
          : Size(maxCrossExtent, double.infinity),
    );

    firstRegularChild.layout(childConstraints, parentUsesSize: true);
    final double childExtent = _getMainSize(firstRegularChild);
    final double crossExtent = _getCrossSize(firstRegularChild);

    final BoxConstraints fixedChildConstraints = _isHorizontal
        ? childConstraints.tighten(width: childExtent, height: crossExtent)
        : childConstraints.tighten(height: childExtent, width: crossExtent);

    final double childStride = childExtent + _spacing;
    final int totalChildren = childCount - 1; // Exclude overflow indicator

    // Calculate how many children fit
    final double requestedExtent =
        childExtent * totalChildren + _spacing * (totalChildren - 1);

    int renderedChildCount;
    if (requestedExtent <= maxExtent) {
      renderedChildCount = totalChildren;
    } else {
      // Account for overflow indicator space
      renderedChildCount =
          childStride > 0 ? ((maxExtent + _spacing) / childStride).floor() - 1 : 0;
      renderedChildCount = math.max(0, renderedChildCount);
    }

    final int unRenderedChildCount = totalChildren - renderedChildCount;
    final List<RenderBox> visibleChildren = [];

    // Collect children to render
    RenderBox? child = firstChild;
    int index = 0;
    while (child != lastChild && child != null) {
      final parentData = child.parentData as BeOverflowViewParentData;

      if (_reverse) {
        // For reverse, we count from the end
        final int reverseIndex = totalChildren - 1 - index;
        if (reverseIndex < renderedChildCount) {
          visibleChildren.add(child);
          parentData.offstage = false;
        } else {
          parentData.offstage = true;
        }
      } else {
        if (index < renderedChildCount) {
          visibleChildren.add(child);
          parentData.offstage = false;
        } else {
          parentData.offstage = true;
        }
      }

      child = parentData.nextSibling;
      index++;
    }

    // Reverse the order if needed
    if (_reverse) {
      visibleChildren.setAll(0, visibleChildren.reversed.toList());
    }

    // Layout and position visible children
    double offset = 0;
    for (int i = 0; i < visibleChildren.length; i++) {
      final visibleChild = visibleChildren[i];
      if (i > 0) {
        visibleChild.layout(fixedChildConstraints, parentUsesSize: true);
      }
      final parentData = visibleChild.parentData as BeOverflowViewParentData;
      parentData.offset = _getOffset(offset, 0);
      offset += childStride;
    }

    // Layout overflow indicator if needed
    if (unRenderedChildCount > 0) {
      final RenderBox overflowIndicator = lastChild!;
      final overflowConstraints = BeBoxValueConstraints<int>.fromConstraints(
        value: unRenderedChildCount,
        constraints: fixedChildConstraints,
      );
      overflowIndicator.layout(overflowConstraints, parentUsesSize: true);

      final parentData =
          overflowIndicator.parentData as BeOverflowViewParentData;
      parentData.offset = _getOffset(offset, 0);
      parentData.offstage = false;
      offset += _getMainSize(overflowIndicator);
    } else {
      final parentData = lastChild!.parentData as BeOverflowViewParentData;
      parentData.offstage = true;
    }

    // Calculate final size
    final double mainAxisExtent =
        renderedChildCount > 0 ? offset - (unRenderedChildCount > 0 ? 0 : _spacing) : 0;

    final requestedSize = _isHorizontal
        ? Size(mainAxisExtent, crossExtent)
        : Size(crossExtent, mainAxisExtent);

    size = constraints.constrain(requestedSize);
  }

  void _performFlexibleLayout() {
    final double maxExtent =
        _isHorizontal ? constraints.maxWidth : constraints.maxHeight;
    final double maxCrossExtent =
        _isHorizontal ? constraints.maxHeight : constraints.maxWidth;

    final BoxConstraints childConstraints = BoxConstraints.loose(
      _isHorizontal
          ? Size(double.infinity, maxCrossExtent)
          : Size(maxCrossExtent, double.infinity),
    );

    double availableExtent = maxExtent;
    double offset = 0;
    int unRenderedChildCount = childCount - 1;
    final List<RenderBox> visibleChildren = [];

    // Collect all regular children
    final List<RenderBox> regularChildren = [];
    RenderBox? child = firstChild;
    while (child != lastChild && child != null) {
      regularChildren.add(child);
      child = (child.parentData as BeOverflowViewParentData).nextSibling;
    }

    // Process in reverse order if needed
    final childrenToProcess = _reverse ? regularChildren.reversed.toList() : regularChildren;

    bool showOverflowIndicator = false;
    for (final currentChild in childrenToProcess) {
      final parentData = currentChild.parentData as BeOverflowViewParentData;
      currentChild.layout(childConstraints, parentUsesSize: true);

      final double childMainSize = _getMainSize(currentChild);
      final double spaceNeeded =
          visibleChildren.isEmpty ? childMainSize : childMainSize + _spacing;

      if (spaceNeeded <= availableExtent) {
        visibleChildren.add(currentChild);
        parentData.offstage = false;
        parentData.offset = _getOffset(offset, 0);

        offset += spaceNeeded;
        availableExtent -= spaceNeeded;
        unRenderedChildCount--;
      } else {
        showOverflowIndicator = true;
        parentData.offstage = true;
      }
    }

    // Mark remaining children as offstage
    for (final currentChild in childrenToProcess) {
      final parentData = currentChild.parentData as BeOverflowViewParentData;
      parentData.offstage ??= true;
    }

    if (showOverflowIndicator && unRenderedChildCount > 0) {
      final RenderBox overflowIndicator = lastChild!;
      var overflowConstraints = BeBoxValueConstraints<int>.fromConstraints(
        value: unRenderedChildCount,
        constraints: childConstraints,
      );
      overflowIndicator.layout(overflowConstraints, parentUsesSize: true);

      double indicatorSize = _getMainSize(overflowIndicator);
      double spaceNeeded =
          visibleChildren.isEmpty ? indicatorSize : indicatorSize + _spacing;

      // Remove children until indicator fits
      while (spaceNeeded > availableExtent && visibleChildren.isNotEmpty) {
        final removed = visibleChildren.removeLast();
        final removedData = removed.parentData as BeOverflowViewParentData;
        removedData.offstage = true;

        final removedSize = _getMainSize(removed);
        final removedSpace =
            visibleChildren.isEmpty ? removedSize : removedSize + _spacing;

        availableExtent += removedSpace;
        offset -= removedSpace;
        unRenderedChildCount++;
      }

      // Re-layout indicator if count changed
      if (overflowConstraints.value != unRenderedChildCount) {
        overflowConstraints = BeBoxValueConstraints<int>.fromConstraints(
          value: unRenderedChildCount,
          constraints: childConstraints,
        );
        overflowIndicator.layout(overflowConstraints, parentUsesSize: true);
        indicatorSize = _getMainSize(overflowIndicator);
      }

      if (indicatorSize > availableExtent) {
        _hasOverflow = true;
      }

      final indicatorData =
          overflowIndicator.parentData as BeOverflowViewParentData;
      indicatorData.offset =
          _getOffset(visibleChildren.isEmpty ? 0 : offset + _spacing, 0);
      indicatorData.offstage = false;
      visibleChildren.add(overflowIndicator);
      offset += visibleChildren.length == 1 ? indicatorSize : indicatorSize + _spacing;
    } else {
      // All children fit, hide overflow indicator
      final indicatorData = lastChild!.parentData as BeOverflowViewParentData;
      indicatorData.offstage = true;

      // Layout indicator offstage to prevent errors
      lastChild!.layout(
        BeBoxValueConstraints<int>.fromConstraints(
          value: 0,
          constraints: childConstraints,
        ),
        parentUsesSize: true,
      );
    }

    // Center children in cross axis
    final double crossSize = visibleChildren.fold<double>(
      0,
      (prev, child) => math.max(prev, _getCrossSize(child)),
    );

    for (final visibleChild in visibleChildren) {
      final parentData = visibleChild.parentData as BeOverflowViewParentData;
      final double childCrossPosition =
          crossSize / 2.0 - _getCrossSize(visibleChild) / 2.0;

      parentData.offset = _isHorizontal
          ? Offset(parentData.offset.dx, childCrossPosition)
          : Offset(childCrossPosition, parentData.offset.dy);
    }

    final Size idealSize = _isHorizontal
        ? Size(offset, crossSize)
        : Size(crossSize, offset);

    size = constraints.constrain(idealSize);
  }

  void _visitOnstageChildren(RenderObjectVisitor visitor) {
    visitChildren((child) {
      final parentData = child.parentData as BeOverflowViewParentData;
      if (parentData.offstage == false) {
        visitor(child);
      }
    });
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    _visitOnstageChildren(visitor);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void paintChildren(PaintingContext context, Offset offset) {
      _visitOnstageChildren((child) {
        final parentData = child.parentData as BeOverflowViewParentData;
        context.paintChild(child as RenderBox, parentData.offset + offset);
      });
    }

    if (_hasOverflow) {
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        paintChildren,
        clipBehavior: Clip.hardEdge,
      );
    } else {
      paintChildren(context, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Iterate in reverse paint order for correct hit testing
    RenderBox? child = lastChild;
    while (child != null) {
      final parentData = child.parentData as BeOverflowViewParentData;
      if (parentData.offstage == false) {
        final bool isHit = result.addWithPaintOffset(
          offset: parentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            return child!.hitTest(result, position: transformed);
          },
        );
        if (isHit) return true;
      }
      child = parentData.previousSibling;
    }
    return false;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (_isHorizontal) {
      double width = 0;
      _visitOnstageChildren((child) {
        width += (child as RenderBox).getMinIntrinsicWidth(height);
      });
      final int count = _countOnstageChildren();
      if (count > 1) width += (count - 1) * _spacing;
      return width;
    } else {
      double maxWidth = 0;
      _visitOnstageChildren((child) {
        maxWidth = math.max(
            maxWidth, (child as RenderBox).getMinIntrinsicWidth(height));
      });
      return maxWidth;
    }
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (_isHorizontal) {
      double width = 0;
      _visitOnstageChildren((child) {
        width += (child as RenderBox).getMaxIntrinsicWidth(height);
      });
      final int count = _countOnstageChildren();
      if (count > 1) width += (count - 1) * _spacing;
      return width;
    } else {
      double maxWidth = 0;
      _visitOnstageChildren((child) {
        maxWidth = math.max(
            maxWidth, (child as RenderBox).getMaxIntrinsicWidth(height));
      });
      return maxWidth;
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (!_isHorizontal) {
      double height = 0;
      _visitOnstageChildren((child) {
        height += (child as RenderBox).getMinIntrinsicHeight(width);
      });
      final int count = _countOnstageChildren();
      if (count > 1) height += (count - 1) * _spacing;
      return height;
    } else {
      double maxHeight = 0;
      _visitOnstageChildren((child) {
        maxHeight = math.max(
            maxHeight, (child as RenderBox).getMinIntrinsicHeight(width));
      });
      return maxHeight;
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (!_isHorizontal) {
      double height = 0;
      _visitOnstageChildren((child) {
        height += (child as RenderBox).getMaxIntrinsicHeight(width);
      });
      final int count = _countOnstageChildren();
      if (count > 1) height += (count - 1) * _spacing;
      return height;
    } else {
      double maxHeight = 0;
      _visitOnstageChildren((child) {
        maxHeight = math.max(
            maxHeight, (child as RenderBox).getMaxIntrinsicHeight(width));
      });
      return maxHeight;
    }
  }

  int _countOnstageChildren() {
    int count = 0;
    _visitOnstageChildren((_) => count++);
    return count;
  }
}

/// Extension to check if a RenderObject is onstage.
extension RenderBeOverflowViewExtension on RenderObject {
  bool get isOnstageInOverflowView {
    final parentData = this.parentData;
    if (parentData is BeOverflowViewParentData) {
      return parentData.offstage == false;
    }
    return true;
  }
}
