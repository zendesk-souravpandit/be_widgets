// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// BoxConstraints that carries an additional value of type [T].
///
/// Used internally to pass the remaining item count to the overflow indicator.
class BeBoxValueConstraints<T> extends BoxConstraints {
  const BeBoxValueConstraints({
    required this.value,
    required super.minWidth,
    required super.maxWidth,
    required super.minHeight,
    required super.maxHeight,
  });

  /// Creates value constraints from existing [BoxConstraints].
  BeBoxValueConstraints.fromConstraints({
    required this.value,
    required BoxConstraints constraints,
  }) : super(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
          minHeight: constraints.minHeight,
          maxHeight: constraints.maxHeight,
        );

  /// The value embedded in these constraints.
  final T value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is BeBoxValueConstraints<T> &&
        other.value == value &&
        super == other;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, value);

  @override
  String toString() {
    return 'BeBoxValueConstraints(value: $value, ${super.toString()})';
  }
}

/// Signature for the builder function used by [BeValueLayoutBuilder].
typedef BeValueLayoutWidgetBuilder<T> = Widget Function(
  BuildContext context,
  BeBoxValueConstraints<T> constraints,
);

/// A widget that builds its child based on [BeBoxValueConstraints].
///
/// Similar to [LayoutBuilder] but receives [BeBoxValueConstraints] which
/// includes both layout constraints and an embedded value.
class BeValueLayoutBuilder<T> extends RenderObjectWidget {
  const BeValueLayoutBuilder({
    super.key,
    required this.builder,
  });

  /// The builder function that creates the child widget.
  final BeValueLayoutWidgetBuilder<T> builder;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBeValueLayoutBuilder<T>();
  }

  @override
  _BeValueLayoutBuilderElement<T> createElement() {
    return _BeValueLayoutBuilderElement<T>(this);
  }
}

class _BeValueLayoutBuilderElement<T> extends RenderObjectElement {
  _BeValueLayoutBuilderElement(BeValueLayoutBuilder<T> super.widget);

  Element? _child;
  BeBoxValueConstraints<T>? _lastConstraints;

  @override
  BeValueLayoutBuilder<T> get widget => super.widget as BeValueLayoutBuilder<T>;

  @override
  _RenderBeValueLayoutBuilder<T> get renderObject =>
      super.renderObject as _RenderBeValueLayoutBuilder<T>;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) {
      visitor(_child!);
    }
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    renderObject._updateCallback(_layoutCallback);
  }

  @override
  void update(BeValueLayoutBuilder<T> newWidget) {
    super.update(newWidget);
    renderObject._updateCallback(_layoutCallback);
    renderObject.markNeedsLayout();
  }

  @override
  void performRebuild() {
    renderObject.markNeedsLayout();
    super.performRebuild();
  }

  @override
  void unmount() {
    renderObject._updateCallback(null);
    super.unmount();
  }

  void _layoutCallback(BeBoxValueConstraints<T> constraints) {
    @pragma('vm:notify-debugger-on-exception')
    void layoutCallback() {
      Widget built;
      try {
        built = widget.builder(this, constraints);
      } catch (e, stack) {
        built = ErrorWidget.builder(
          FlutterErrorDetails(
            exception: e,
            stack: stack,
            library: 'be_widgets',
            context: ErrorDescription('building $widget'),
          ),
        );
      }
      _child = updateChild(_child, built, null);
    }

    if (constraints != _lastConstraints) {
      _lastConstraints = constraints;
      owner!.buildScope(this, layoutCallback);
    }
  }

  @override
  void insertRenderObjectChild(RenderObject child, Object? slot) {
    final RenderObjectWithChildMixin<RenderBox> renderObject = this.renderObject;
    renderObject.child = child as RenderBox;
  }

  @override
  void moveRenderObjectChild(
      RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    final RenderObjectWithChildMixin<RenderBox> renderObject = this.renderObject;
    assert(renderObject.child == child);
    renderObject.child = null;
  }
}

class _RenderBeValueLayoutBuilder<T> extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  LayoutCallback<BeBoxValueConstraints<T>>? _callback;

  void _updateCallback(LayoutCallback<BeBoxValueConstraints<T>>? callback) {
    if (_callback == callback) return;
    _callback = callback;
    markNeedsLayout();
  }

  bool _debugThrowIfNotCheckingIntrinsics() {
    assert(() {
      if (!RenderObject.debugCheckingIntrinsics) {
        throw FlutterError(
          'BeValueLayoutBuilder does not support returning intrinsic dimensions.\n'
          'Calculating the intrinsic dimensions would require running the layout '
          'callback speculatively, which might mutate the live render object tree.',
        );
      }
      return true;
    }());
    return true;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  void performLayout() {
    final BoxConstraints rawConstraints = constraints;
    if (rawConstraints is BeBoxValueConstraints<T> && _callback != null) {
      invokeLayoutCallback(_callback!);
    }

    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result, position: position) ?? false;
  }
}
