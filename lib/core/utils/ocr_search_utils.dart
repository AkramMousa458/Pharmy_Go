import 'package:flutter/material.dart';
import 'package:pharmygo/public/views/ocr_page.dart';
import 'package:pharmygo/public/widgets/custom_search.dart';

String normalizeScannedDrugName(String raw) {
  return raw
      .replaceAll(RegExp(r'[\n\r\t]+'), ' ')
      .replaceAll(RegExp(r'[^\w\s\u0600-\u06FF.-]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

List<String> drugSearchTerms(String query) {
  final normalized = normalizeScannedDrugName(query).toLowerCase();
  if (normalized.isEmpty) return [];

  final terms = <String>{normalized};
  final words = normalized
      .split(' ')
      .where((word) => word.length >= 3)
      .toList()
    ..sort((a, b) => b.length.compareTo(a.length));

  terms.addAll(words);
  return terms.toList();
}

Future<void> openOcrThenSearch(BuildContext context) async {
  final result = await Navigator.pushNamed(context, OcrPage.routeName);
  if (!context.mounted) return;

  final searchTerm = result is String ? normalizeScannedDrugName(result) : '';
  if (searchTerm.isNotEmpty) {
    showDrugSearch(context, searchTerm: searchTerm);
  }
}
