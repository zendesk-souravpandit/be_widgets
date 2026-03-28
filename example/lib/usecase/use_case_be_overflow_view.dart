import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Tag Chips', path: '/', type: BeOverflowView)
Widget renderTagChipsOverflow(BuildContext context) {
  final spacing = context.knobs.double
      .slider(label: 'Spacing', initialValue: 8, min: 0, max: 16);
  final containerWidth = context.knobs.double
      .slider(label: 'Container Width', initialValue: 300, min: 150, max: 500);
  final tagCount = context.knobs.int
      .slider(label: 'Tag Count', initialValue: 8, min: 1, max: 15);
  final isFlexible = context.knobs.boolean(label: 'Flexible Mode', initialValue: true);

  final tags = [
    'Flutter',
    'Dart',
    'UI/UX',
    'Mobile',
    'Web',
    'Desktop',
    'Open Source',
    'Performance',
    'Responsive',
    'Material',
    'Cupertino',
    'Animation',
    'State Management',
    'Firebase',
    'GraphQL',
  ];

  final tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];

  Widget buildChips() {
    final children = List.generate(
      tagCount,
      (i) => Chip(
        label: Text(tags[i % tags.length]),
        backgroundColor: tagColors[i % tagColors.length].withValues(alpha: 0.15),
        labelStyle: TextStyle(
          color: tagColors[i % tagColors.length].shade700,
          fontSize: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );

    if (isFlexible) {
      return BeOverflowView.flexible(
        spacing: spacing,
        builder: (context, count) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '+$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        children: children,
      );
    }

    return BeOverflowView(
      spacing: spacing,
      builder: (context, count) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '+$count',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      children: children,
    );
  }

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Article Tags',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: containerWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: buildChips(),
        ),
        const SizedBox(height: 16),
        Text(
          'Resize container width to see overflow behavior',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Avatar Stack', path: '/', type: BeOverflowView)
Widget renderAvatarStackOverflow(BuildContext context) {
  final avatarCount = context.knobs.int
      .slider(label: 'Avatar Count', initialValue: 7, min: 1, max: 12);
  final containerWidth = context.knobs.double
      .slider(label: 'Container Width', initialValue: 200, min: 100, max: 400);
  final avatarSize = context.knobs.double
      .slider(label: 'Avatar Size', initialValue: 36, min: 24, max: 56);
  final overlap = context.knobs.double
      .slider(label: 'Overlap', initialValue: 8, min: 0, max: 20);

  final names = [
    'Alice',
    'Bob',
    'Carol',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Henry',
    'Ivy',
    'Jack',
    'Kate',
    'Leo',
  ];

  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
    Colors.lime,
    Colors.brown,
  ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Team Members',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          width: containerWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BeOverflowView(
            spacing: -overlap,
            builder: (context, count) => CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: Colors.grey.shade400,
              child: Text(
                '+$count',
                style: TextStyle(
                  fontSize: avatarSize * 0.35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            children: List.generate(
              avatarCount,
              (i) => CircleAvatar(
                radius: avatarSize / 2,
                backgroundColor: colors[i % colors.length],
                child: Text(
                  names[i % names.length][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: avatarSize * 0.4,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Use negative spacing for overlapping avatars',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Action Buttons', path: '/', type: BeOverflowView)
Widget renderActionButtonsOverflow(BuildContext context) {
  final containerWidth = context.knobs.double
      .slider(label: 'Container Width', initialValue: 280, min: 120, max: 500);
  final reverse = context.knobs.boolean(label: 'Reverse Order', initialValue: false);

  final actions = [
    (Icons.edit, 'Edit', Colors.blue),
    (Icons.share, 'Share', Colors.green),
    (Icons.delete, 'Delete', Colors.red),
    (Icons.archive, 'Archive', Colors.orange),
    (Icons.star, 'Star', Colors.amber),
    (Icons.download, 'Download', Colors.purple),
  ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Document Actions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          width: containerWidth,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: BeOverflowView.flexible(
            spacing: 4,
            reverse: reverse,
            builder: (context, count) => PopupMenuButton<String>(
              tooltip: 'More actions',
              itemBuilder: (context) => actions
                  .skip(actions.length - count)
                  .map((a) => PopupMenuItem(
                        value: a.$2,
                        child: Row(
                          children: [
                            Icon(a.$1, size: 18, color: a.$3),
                            const SizedBox(width: 8),
                            Text(a.$2),
                          ],
                        ),
                      ))
                  .toList(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.more_horiz, size: 18, color: Colors.grey.shade700),
                    const SizedBox(width: 4),
                    Text(
                      '+$count',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            children: actions
                .map((a) => TextButton.icon(
                      onPressed: () {},
                      icon: Icon(a.$1, size: 18),
                      label: Text(a.$2),
                      style: TextButton.styleFrom(
                        foregroundColor: a.$3,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Toggle "Reverse Order" to prioritize last actions',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Toolbar with Menu', path: '/', type: BeOverflowView)
Widget renderToolbarWithMenu(BuildContext context) {
  final containerWidth = context.knobs.double
      .slider(label: 'Container Width', initialValue: 350, min: 150, max: 600);

  final menuItems = [
    (Icons.insert_drive_file_outlined, 'File'),
    (Icons.save_outlined, 'Save'),
    (Icons.edit_outlined, 'Edit'),
    (Icons.visibility_outlined, 'View'),
    (Icons.open_in_new, 'Export'),
    (Icons.text_fields, 'Long Command'),
    (Icons.wrap_text, 'Very Long Command'),
    (Icons.more_time, 'Very very Long Command'),
    (Icons.help_outline, 'Help'),
  ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Toolbar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          width: containerWidth,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: BeOverflowView.flexible(
            spacing: 0,
            builder: (context, count) {
              final hiddenItems = menuItems.sublist(menuItems.length - count);
              return PopupMenuButton<String>(
                tooltip: 'More options',
                icon: Icon(Icons.menu, color: Colors.grey.shade700),
                padding: EdgeInsets.zero,
                itemBuilder: (context) => hiddenItems
                    .map((item) => PopupMenuItem(
                          value: item.$2,
                          child: Row(
                            children: [
                              Icon(item.$1, size: 18, color: Colors.grey.shade700),
                              const SizedBox(width: 12),
                              Text(item.$2),
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
            children: menuItems.map((item) {
              return TextButton.icon(
                onPressed: () {},
                icon: Icon(item.$1, size: 18),
                label: Text(item.$2),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade800,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Resize to see items move into hamburger menu',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Nested Overflow', path: '/', type: BeOverflowView)
Widget renderNestedOverflow(BuildContext context) {
  final containerWidth = context.knobs.double
      .slider(label: 'Container Width', initialValue: 120, min: 60, max: 200);
  final avatarSize = context.knobs.double
      .slider(label: 'Avatar Size', initialValue: 32, min: 20, max: 48);

  final names = ['AD', 'JG', 'DA', 'JA', 'CB', 'RR', 'JD', 'MB', 'AA', 'BA'];
  final colors = [
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.black,
    Colors.deepPurple,
    Colors.red,
    Colors.orange,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
  ];

  Widget buildAvatar(int index) {
    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundColor: colors[index % colors.length],
      child: Text(
        names[index % names.length],
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: avatarSize * 0.35,
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nested Overflow Views',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),

        // Outer vertical overflow containing rows of avatars
        Container(
          width: containerWidth,
          height: 250,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BeOverflowView.flexible(
            direction: Axis.vertical,
            spacing: 8,
            builder: (context, count) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.expand_more, size: 16, color: Colors.blue.shade700),
                  Text(
                    ' +$count rows',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              // Row 1: Single large avatar
              buildAvatar(0),

              // Row 2: Single large avatar
              buildAvatar(1),

              // Row 3: Nested horizontal overflow with smaller avatars
              BeOverflowView(
                spacing: -8,
                builder: (context, count) => CircleAvatar(
                  radius: avatarSize * 0.4,
                  backgroundColor: Colors.grey.shade600,
                  child: Text(
                    '+$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: avatarSize * 0.28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                children: [
                  for (var i = 2; i < 8; i++)
                    CircleAvatar(
                      radius: avatarSize * 0.4,
                      backgroundColor: colors[i % colors.length],
                      child: Text(
                        names[i % names.length],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: avatarSize * 0.25,
                        ),
                      ),
                    ),
                ],
              ),

              // Row 4: Another nested row
              BeOverflowView(
                spacing: -6,
                builder: (context, count) => CircleAvatar(
                  radius: avatarSize * 0.35,
                  backgroundColor: Colors.grey.shade500,
                  child: Text(
                    '+$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: avatarSize * 0.22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                children: [
                  for (var i = 5; i < 10; i++)
                    CircleAvatar(
                      radius: avatarSize * 0.35,
                      backgroundColor: colors[i % colors.length],
                      child: Text(
                        names[i % names.length],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: avatarSize * 0.22,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Nested BeOverflowView widgets (vertical + horizontal)',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Vertical List', path: '/', type: BeOverflowView)
Widget renderVerticalOverflow(BuildContext context) {
  final containerHeight = context.knobs.double
      .slider(label: 'Container Height', initialValue: 200, min: 80, max: 400);
  final itemCount = context.knobs.int
      .slider(label: 'Item Count', initialValue: 8, min: 1, max: 15);

  final notifications = [
    'New message from Alice',
    'Bob liked your post',
    'Meeting reminder at 3 PM',
    'Carol commented on your photo',
    'System update available',
    'David sent you a file',
    'Weekly report is ready',
    'Eve mentioned you',
    'New follower: Frank',
    'Payment received',
    'Grace shared a document',
    'Task deadline tomorrow',
    'New comment on your blog',
    'Henry joined the team',
    'Backup completed',
  ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          width: 300,
          height: containerHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: BeOverflowView.flexible(
            direction: Axis.vertical,
            spacing: 0,
            builder: (context, count) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.expand_more, size: 18, color: Colors.blue.shade700),
                  const SizedBox(width: 4),
                  Text(
                    'View $count more notifications',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            children: List.generate(
              itemCount,
              (i) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.primaries[i % Colors.primaries.length].shade100,
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 16,
                        color: Colors.primaries[i % Colors.primaries.length],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        notifications[i % notifications.length],
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Vertical direction with flexible sizing',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    ),
  );
}
