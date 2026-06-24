import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/ocr_search_utils.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});
  static const String routeName = '/ocrPage';

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  final TextEditingController _textController = TextEditingController();
  Timer? _debounceTimer;
  bool _searchTriggered = false;
  bool _hasPendingUpdate = false;
  String _scannedText = '';
  String? _pendingText;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _onScannedText(String value) {
    final cleaned = normalizeScannedDrugName(value);
    if (cleaned.isEmpty) return;

    _pendingText = cleaned;
    if (_hasPendingUpdate) return;
    _hasPendingUpdate = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hasPendingUpdate = false;
      if (!mounted) return;

      final text = _pendingText;
      if (text == null || text.isEmpty || text == _scannedText) return;

      _scannedText = text;
      if (_textController.text != text) {
        _textController.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
      _scheduleAutoSearch(text);
    });
  }

  void _scheduleAutoSearch(String text) {
    _debounceTimer?.cancel();
    if (text.length < 3 || _searchTriggered) return;

    _debounceTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted || _searchTriggered) return;
      final current = normalizeScannedDrugName(_textController.text);
      if (current.length >= 3 && current == text) {
        _completeSearch(current);
      }
    });
  }

  void _completeSearch(String searchTerm) {
    final cleaned = normalizeScannedDrugName(searchTerm);
    if (cleaned.isEmpty) {
      showSnackBar(context, 'Scan a drug name first');
      return;
    }

    _searchTriggered = true;
    Navigator.pop(context, cleaned);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AppBar(
          title: Text(
            'Scan Drug',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ScalableOCR(
              paintboxCustom: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4.0
                ..color = const Color.fromARGB(153, 102, 160, 241),
              boxLeftOff: 5,
              boxBottomOff: 2.5,
              boxRightOff: 5,
              boxTopOff: 2.5,
              boxHeight: MediaQuery.of(context).size.height / 3,
              getScannedText: _onScannedText,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: BoxDecoration(
              color: ThemeColors.kBackgroundColor(context),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Detected drug name',
                  style: TextStyle(
                    color: ThemeColors.kGreyColor(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _textController,
                  onChanged: (value) {
                    _scannedText = normalizeScannedDrugName(value);
                    _searchTriggered = false;
                    _scheduleAutoSearch(_scannedText);
                  },
                  decoration: InputDecoration(
                    hintText: 'Point the camera at the drug name',
                    filled: true,
                    fillColor: ThemeColors.kSecondBackgroundColor(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeColors.kLightGreyColor(context)
                            .withValues(alpha: 0.4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeColors.kLightGreyColor(context)
                            .withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: ThemeColors.kSecondColor(context),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Search starts automatically when the name is detected, or tap below.',
                  style: TextStyle(
                    color: ThemeColors.kGreyColor(context),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _completeSearch(_textController.text),
                  icon: const Icon(Icons.search_rounded),
                  label: const Text('Search Drug'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.kMainColor(context),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
