import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// Widget for entering a 6-digit verification code.
class VerificationCodeInput extends StatefulWidget {
  final void Function(String) onCompleted;

  /// Creates a [VerificationCodeInput] with a callback for completed input.
  const VerificationCodeInput({super.key, required this.onCompleted});

  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

/// Manages the state for the verification code input field.
class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final int _codeLength = 6;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Cleans up controller and focus node on widget disposal.
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Handles input changes and triggers callback when code is complete.
  void _onChanged(String value) {
    if (value.length == _codeLength) {
      widget.onCompleted(value);
    }
    setState(() {});
  }

  /// Builds the UI with a visual code display and hidden input field.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: Container(
        width: (_codeLength * 32) + (3 * 4) + 16,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: primarily0InvincibleColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildHiddenInputField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_codeLength, (index) {
                String displayChar = _controller.text.length > index
                    ? _controller.text[index]
                    : '-';

                bool isSpacingBlock = index == 2; // Space after third input

                return Padding(
                  padding: EdgeInsets.only(right: isSpacingBlock ? 24 : 0),
                  child: Container(
                    width: 24,
                    height: 48,
                    alignment: Alignment.center,
                    child: Text(
                      displayChar,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a hidden text field for numeric input.
  Widget buildHiddenInputField() {
    return Opacity(
      opacity: 0.0,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLength: _codeLength,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: _onChanged,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
