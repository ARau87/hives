import 'package:flutter/material.dart';

/// A collapsible form section with an animated expand/collapse header.
///
/// Renders a 15px SemiBold header with an animated chevron. Supports
/// collapsible and required (always-visible) variants.
class HivesFormSection extends StatefulWidget {
  const HivesFormSection({
    super.key,
    required this.title,
    this.isCollapsible = true,
    this.isInitiallyExpanded = false,
    required this.child,
  });

  /// Creates a required (non-collapsible, always visible) form section.
  const HivesFormSection.required({
    super.key,
    required this.title,
    required this.child,
  })  : isCollapsible = false,
        isInitiallyExpanded = true;

  /// The section title displayed in the header.
  final String title;

  /// Whether the section can be collapsed.
  final bool isCollapsible;

  /// Whether the section starts expanded (only applies when collapsible).
  final bool isInitiallyExpanded;

  /// The content widget displayed inside the section.
  final Widget child;

  @override
  State<HivesFormSection> createState() => _HivesFormSectionState();
}

class _HivesFormSectionState extends State<HivesFormSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _chevronAnimation;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isCollapsible ? widget.isInitiallyExpanded : true;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: _isExpanded ? 1.0 : 0.0,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _chevronAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant HivesFormSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsible != oldWidget.isCollapsible) {
      if (!widget.isCollapsible) {
        setState(() {
          _isExpanded = true;
        });
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (!widget.isCollapsible) return;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1px separator above header
        Container(
          height: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        // Header
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isCollapsible ? _toggle : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (widget.isCollapsible)
                    RotationTransition(
                      turns: _chevronAnimation,
                      child: const Icon(
                        Icons.expand_more,
                        semanticLabel: 'Toggle section',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // Animated content
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1.0,
          child: widget.child,
        ),
      ],
    );
  }
}
