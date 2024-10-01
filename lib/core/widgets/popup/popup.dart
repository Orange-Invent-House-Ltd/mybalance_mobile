import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'enhanced_composited_transform_follower.dart';
import 'enhanced_composited_transform_target.dart';

typedef PopupWidgetBuilder = Widget Function(
  BuildContext context,
  OverlayPortalController controller,
);

class Popup extends StatefulWidget {
  const Popup({
    required this.follower,
    required this.child,
    this.controller,
    this.flip = true,
    this.adjustForOverflow = true,
    this.edgeInsets = EdgeInsets.zero,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    this.enforceLeaderWidth = false,
    this.enforceLeaderHeight = false,
    super.key,
  });

  final PopupWidgetBuilder child;

  final PopupWidgetBuilder follower;

  final Alignment followerAnchor;

  final Alignment targetAnchor;

  final EdgeInsets edgeInsets;

  final OverlayPortalController? controller;

  final bool flip;

  final bool adjustForOverflow;

  final bool enforceLeaderWidth;

  final bool enforceLeaderHeight;

  static Iterable<Rect> findDisplayFeatureBounds(
      List<DisplayFeature> features) {
    return features
        .where((DisplayFeature d) =>
            d.bounds.shortestSide > 0 ||
            d.state == DisplayFeatureState.postureHalfOpened)
        .map((DisplayFeature d) => d.bounds);
  }

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  final _layerLink = EnhancedLayerLink();

  late OverlayPortalController portalController;

  @override
  void initState() {
    portalController =
        widget.controller ?? OverlayPortalController(debugLabel: 'Popup');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Popup oldWidget) {
    if (!identical(widget.controller, oldWidget.controller)) {
      portalController =
          widget.controller ?? OverlayPortalController(debugLabel: 'Popup');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final displayFeatureBounds = Popup.findDisplayFeatureBounds(
      MediaQuery.displayFeaturesOf(context),
    );

    return EnhancedCompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: portalController,
        child: widget.child(context, portalController),
        overlayChildBuilder: (BuildContext context) => Center(
          child: EnhancedCompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: widget.followerAnchor,
            targetAnchor: widget.targetAnchor,
            edgePadding: widget.edgeInsets,
            flip: widget.flip,
            adjustForOverflow: widget.adjustForOverflow,
            enforceLeaderWidth: widget.enforceLeaderWidth,
            enforceLeaderHeight: widget.enforceLeaderHeight,
            displayFeatureBounds: displayFeatureBounds,
            child: Builder(
                builder: (context) =>
                    widget.follower(context, portalController)),
          ),
        ),
      ),
    );
  }
}

typedef PopupFollowerBuilder = Widget Function(
    BuildContext context, Widget? child);

abstract interface class PopupFollowerController {
  void dismiss();
}

class PopupFollower extends StatefulWidget {
  const PopupFollower({
    required this.child,
    this.onDismiss,
    this.tapRegionGroupId,
    this.focusScopeNode,
    this.skipTraversal,
    this.consumeOutsideTaps = false,
    this.dismissOnResize = false,
    this.dismissOnScroll = true,
    this.constraints = const BoxConstraints(),
    this.autofocus = true,
    super.key,
  }) : assert(child != null);

  final Widget? child;

  final VoidCallback? onDismiss;

  final BoxConstraints constraints;

  final Object? tapRegionGroupId;

  final bool consumeOutsideTaps;

  final bool dismissOnResize;

  final bool dismissOnScroll;

  final bool autofocus;

  final FocusScopeNode? focusScopeNode;

  final bool? skipTraversal;

  @override
  State<PopupFollower> createState() => PopupFollowerState();
}

class PopupFollowerState extends State<PopupFollower>
    with WidgetsBindingObserver
    implements PopupFollowerController {
  FollowerScope? _parent;
  ScrollPosition? _scrollPosition;

  bool get isRoot => _parent == null;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollPosition?.removeListener(_scrollableListener);
    _scrollPosition = Scrollable.maybeOf(context)?.position
      ?..addListener(_scrollableListener);
    _parent = FollowerScope.maybeOf(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  void didChangeMetrics() {
    if (widget.dismissOnResize) {
      widget.onDismiss?.call();
    }
    super.didChangeMetrics();
  }

  void _scrollableListener() {
    if (widget.onDismiss != null && widget.dismissOnScroll && isRoot) {
      widget.onDismiss?.call();
    }
  }

  @override
  void dismiss() {
    if (widget.onDismiss != null && isRoot) {
      widget.onDismiss?.call();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollPosition?.removeListener(_scrollableListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FollowerScope(
        controller: this,
        parent: _parent,
        child: Actions(
          actions: {
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (intent) => widget.onDismiss?.call(),
            ),
          },
          child: Shortcuts(
            debugLabel: 'PopupFollower',
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
            },
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              child: FocusScope(
                debugLabel: 'PopupFollower',
                node: widget.focusScopeNode,
                skipTraversal: widget.skipTraversal,
                canRequestFocus: true,
                child: TapRegion(
                  debugLabel: 'PopupFollower',
                  groupId: widget.tapRegionGroupId,
                  consumeOutsideTaps: widget.consumeOutsideTaps,
                  onTapOutside: (_) => widget.onDismiss?.call(),
                  child: ConstrainedBox(
                    constraints: widget.constraints,
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class FollowerScope extends InheritedWidget {
  const FollowerScope({
    required super.child,
    required this.controller,
    this.parent,
    super.key,
  });

  final PopupFollowerController controller;
  final FollowerScope? parent;

  static FollowerScope? maybeOf(BuildContext context, {bool listen = false}) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<FollowerScope>()
        : context
            .getElementForInheritedWidgetOfExactType<FollowerScope>()
            ?.widget as FollowerScope?;
  }

  static FollowerScope? findRootOf(BuildContext context,
      {bool listen = false}) {
    var scope = maybeOf(context, listen: listen);
    while (scope?.parent != null) {
      scope = scope?.parent;
    }
    return scope;
  }

  @override
  bool updateShouldNotify(FollowerScope oldWidget) => false;
}
