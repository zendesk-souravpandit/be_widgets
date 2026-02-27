import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Line Trim Mode', path: '/BeTextMore', type: BeTextMore)
Widget renderLineTrimMode(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 3, min: 1, max: 6);
  final fontSize = context.knobs.double
      .slider(label: 'Font Size', initialValue: 16, min: 12, max: 24);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TrimMode.line - Trims by line count',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'This is a premium product with many features. It is designed for modern users who value quality, reliability, and style. The product comes with a 2-year warranty and 24/7 customer support. You can use it in various environments and it adapts to your needs. For more details, expand this section.',
              trimMode: TrimMode.line,
              trimLines: trimLines,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
              colorClickableText: Colors.blue,
              style: TextStyle(fontSize: fontSize, color: Colors.black87),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'Length Trim Mode', path: '/BeTextMore', type: BeTextMore)
Widget renderLengthTrimMode(final BuildContext context) {
  final trimLength = context.knobs.int
      .slider(label: 'Trim Length', initialValue: 100, min: 50, max: 300);
  final fontSize = context.knobs.double
      .slider(label: 'Font Size', initialValue: 16, min: 12, max: 24);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TrimMode.length - Trims by character count',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'This is a premium product with many features. It is designed for modern users who value quality, reliability, and style. The product comes with a 2-year warranty and 24/7 customer support. You can use it in various environments and it adapts to your needs. For more details, expand this section.',
              trimMode: TrimMode.length,
              trimLength: trimLength,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
              colorClickableText: Colors.deepPurple,
              style: TextStyle(fontSize: fontSize, color: Colors.black87),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'With Pre/Post Text', path: '/BeTextMore', type: BeTextMore)
Widget renderWithPrePostText(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 2, min: 1, max: 6);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('With Pre & Post Data Text',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
              trimMode: TrimMode.line,
              trimLines: trimLines,
              preDataText: 'Note:',
              preDataTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16,
              ),
              postDataText: '- End',
              postDataTextStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                fontSize: 14,
              ),
              trimExpandedText: 'Less',
              trimCollapsedText: 'More',
              colorClickableText: Colors.teal,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'With Annotations', path: '/BeTextMore', type: BeTextMore)
Widget renderWithAnnotations(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 3, min: 1, max: 6);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('With Annotations (URLs, Hashtags, Mentions)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'Check out our website at https://example.com for more info! Follow us @company and use #FlutterDev #BeWidgets to share your experience. Contact support@example.com for help. We love building with #Flutter!',
              trimMode: TrimMode.line,
              trimLines: trimLines,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
              colorClickableText: Colors.blue,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              annotations: [
                // URL pattern
                Annotation(
                  regExp: RegExp(r'https?://[^\s]+'),
                  spanBuilder: (
                      {required String text, required TextStyle textStyle}) {
                    return TextSpan(
                      text: text,
                      style: textStyle.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    );
                  },
                ),
                // Hashtag pattern
                Annotation(
                  regExp: RegExp(r'#\w+'),
                  spanBuilder: (
                      {required String text, required TextStyle textStyle}) {
                    return TextSpan(
                      text: text,
                      style: textStyle.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                // Mention pattern
                Annotation(
                  regExp: RegExp(r'@\w+'),
                  spanBuilder: (
                      {required String text, required TextStyle textStyle}) {
                    return TextSpan(
                      text: text,
                      style: textStyle.copyWith(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                // Email pattern
                Annotation(
                  regExp: RegExp(r'[\w.]+@[\w.]+\.\w+'),
                  spanBuilder: (
                      {required String text, required TextStyle textStyle}) {
                    return TextSpan(
                      text: text,
                      style: textStyle.copyWith(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'Custom Styles', path: '/BeTextMore', type: BeTextMore)
Widget renderCustomStyles(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 2, min: 1, max: 6);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Custom More/Less Styles',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'This example shows custom styling for the "more" and "less" links. You can customize the delimiter style as well. The text will be trimmed and styled according to your preferences.',
              trimMode: TrimMode.line,
              trimLines: trimLines,
              trimExpandedText: '▲ Collapse',
              trimCollapsedText: '▼ Expand',
              delimiter: '... ',
              moreStyle: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              lessStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              delimiterStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'Non-Expandable', path: '/BeTextMore', type: BeTextMore)
Widget renderNonExpandable(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 2, min: 1, max: 6);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Non-Expandable (isExpandable: false)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore(
              text:
                  'This text cannot be expanded. The "Show more" link is hidden because isExpandable is set to false. This is useful when you just want to truncate text without allowing expansion.',
              trimMode: TrimMode.line,
              trimLines: trimLines,
              isExpandable: false,
              trimCollapsedText: '', // Empty since not expandable
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Rich Text', path: '/BeTextMore', type: BeTextMore)
Widget renderRichText(final BuildContext context) {
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 3, min: 1, max: 6);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rich Text with TextSpan',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 12),
            BeTextMore.rich(
              const TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  TextSpan(
                    text: 'BeWidgets',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '! This is a ',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  TextSpan(
                    text: 'rich text',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' example with multiple styles. You can mix bold, italic, colors, and more. The widget handles all the complexity of trimming rich text while preserving styles. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              trimMode: TrimMode.line,
              trimLines: trimLines,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
              colorClickableText: Colors.blue,
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
    name: 'External Collapse Control', path: '/BeTextMore', type: BeTextMore)
Widget renderExternalCollapseControl(final BuildContext context) {
  return const _ExternalCollapseControlExample();
}

class _ExternalCollapseControlExample extends StatefulWidget {
  const _ExternalCollapseControlExample();

  @override
  State<_ExternalCollapseControlExample> createState() =>
      _ExternalCollapseControlExampleState();
}

class _ExternalCollapseControlExampleState
    extends State<_ExternalCollapseControlExample> {
  final ValueNotifier<bool> _isCollapsed = ValueNotifier(true);

  @override
  void dispose() {
    _isCollapsed.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('External Collapse Control',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              const Text(
                'Control collapse state from outside the widget',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _isCollapsed.value = true,
                    child: const Text('Collapse'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _isCollapsed.value = false,
                    child: const Text('Expand'),
                  ),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isCollapsed,
                    builder: (final context, final value, final child) {
                      return Text(
                        'State: ${value ? "Collapsed" : "Expanded"}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              BeTextMore(
                text:
                    'This text can be controlled externally using a ValueNotifier. The collapse state is managed outside the widget, allowing you to sync multiple text blocks or control the state programmatically. This is useful for "expand all" / "collapse all" functionality.',
                trimMode: TrimMode.line,
                trimLines: 2,
                isCollapsed: _isCollapsed,
                trimExpandedText: 'Show less',
                trimCollapsedText: 'Show more',
                colorClickableText: Colors.blue,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
