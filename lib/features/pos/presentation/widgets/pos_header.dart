import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../core/constants/app_colors.dart';

class PosHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String> onSearch;
  final ValueChanged<String>? onBarcodeScanned; // بيتنفذ لما السكانر يبعت Enter
  final VoidCallback? onReturn;

  const PosHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    this.focusNode,
    this.onBarcodeScanned,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              onChanged: onSearch,
              onSubmitted: (value) {
                final code = value.trim();

                if (code.isEmpty) {
                  focusNode?.requestFocus();
                  return;
                }

                onBarcodeScanned?.call(code);

                controller.clear();
                onSearch('');

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (focusNode != null && !focusNode!.hasFocus) {
                    focusNode!.requestFocus();
                  }
                });
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'ابحث بالاسم أو امسح الباركود',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: onReturn,
            icon: const Icon(Icons.refresh),
            label: const Text('إرجاع'),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
          ),
        ],
      ),
    );
  }
}

/// Keeps cashier search ready for non-input taps without stealing focus from
/// another editable field.
class PosSearchFocusGuard extends StatefulWidget {
  final FocusNode searchFocusNode;
  final Widget child;

  const PosSearchFocusGuard({
    super.key,
    required this.searchFocusNode,
    required this.child,
  });

  @override
  State<PosSearchFocusGuard> createState() => _PosSearchFocusGuardState();
}

class _PosSearchFocusGuardState extends State<PosSearchFocusGuard> {
  final _listenerKey = GlobalKey();

  void _handlePointerDown(PointerDownEvent event) {
    final renderObject = _listenerKey.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final hitTestResult = BoxHitTestResult();
      final localPosition = renderObject.globalToLocal(event.position);
      renderObject.hitTest(hitTestResult, position: localPosition);
      final tappedEditableText = hitTestResult.path.any(
        (entry) => entry.target is RenderEditable,
      );
      if (tappedEditableText) return;
    }

    if (widget.searchFocusNode.context != null) {
      widget.searchFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      key: _listenerKey,
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      child: widget.child,
    );
  }
}
