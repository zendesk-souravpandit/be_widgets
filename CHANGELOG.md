## 1.3.0

### Added

- **BeOverflowView**: New widget that displays children in a row/column and shows an overflow indicator (e.g., "+3 more") when there's not enough space
  - Supports horizontal and vertical directions
  - Fixed mode: all children have the same size as the first child
  - Flexible mode: each child can have its own size
  - Configurable spacing between items
  - Reverse display order support
  - Custom overflow indicator builder

### Example

```dart
BeOverflowView(
  spacing: 8,
  builder: (context, count) => Text('+$count more'),
  children: [
    Chip(label: Text('Tag 1')),
    Chip(label: Text('Tag 2')),
    Chip(label: Text('Tag 3')),
  ],
)
```

## 1.2.3

### Fixed - BeTextMore

- **Style not applied**: Fixed root TextSpan missing style property
- **Hit test not working**: Fixed "Show more/less" tap detection using correct local coordinates
- **Memory leaks**: Fixed TextPainter instances not being disposed properly
- **Resize handling**: Fixed maxLines constraint incorrectly applied in TrimMode.length mode
- **Word boundary trimming**: Text now trims at word boundaries instead of mid-word for cleaner display
- **Semantics**: Fixed semantics label fallback for rich text content
- **Race condition**: Added null safety guard in collapse state listener
- **Binary search fallback**: Fixed potential crash with empty strings

### Added

- Added comprehensive widgetbook examples for BeTextMore:
  - Line Trim Mode
  - Length Trim Mode
  - With Pre/Post Text
  - With Annotations (URLs, hashtags, mentions, emails)
  - Custom Styles
  - Non-Expandable mode
  - Rich Text support
  - External Collapse Control

## 1.2.2

- doc update

## 1.2.1

- Added demo and showcase example
- added ui widgetbook in example and update real world showcase screen

## 1.2.0

- Introduced new widgets: `be_badge.dart`, `be_multi_badge.dart`, `be_label.dart`, `be_multi_label.dart`, `be_text_more.dart`, `be_size_aware.dart`, `be_wrap.dart`, `be_row.dart`, `be_column.dart`, `be_container.dart`, `be_offset.dart`, `be_breakpoint.dart`.
- Added decoration utilities: `decoration/be_box_decoration.dart`, `decoration/be_box_shadow.dart`, `decoration/be_icon_shape_border.dart`.

- Refactored widget structure to use a modular approach under `lib/src/`.
- Improved code organization by separating decoration-related files into their own subfolder.

- Various minor bug fixes and improvements to widget rendering and responsiveness.

- Added Responsive widget

---

## 1.1.7

- fixed icon decoration type

## 1.1.6

- updated screenshot

## 1.1.5

- Add BeBoxDecoration & BeIconShapeBorder decoration component
- Updated Readme and example

## 1.1.4

- Added BeTextMore for long text display and controll with maxLine.

## 1.1.3

- version bump.

## 1.1.2

- flutter lint upgrade.

## 1.1.1

- flutter lint upgrade.

## 1.1.0

- Add BeOffset & BeTextMore widget.

## 1.0.4

- Added BeOffset for setting offset position without worry about boundary.

## 1.0.3

- added more example
- added screenshot
- updated docs

## 1.0.2

- updated docs

## 1.0.1

- Added Screenshot

## 1.0.0

- Updated documentation

## 0.0.4

- Updated documentation

## 0.0.3

- Added documentation

## 0.0.2

- Added badge and label widget with example

## 0.0.1

- TODO: Describe initial release.
