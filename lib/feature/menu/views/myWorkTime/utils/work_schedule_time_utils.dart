import 'package:flutter/material.dart';

/// Formats API time `HH:mm:ss` to 12-hour clock (e.g. `09:00 AM`, `05:00 PM`).
String formatWorkTimeTo12h(String? raw) {
  if (raw == null || raw.isEmpty) {
    return '';
  }
  final parts = raw.split(':');
  if (parts.length < 2) {
    return raw;
  }
  final h24 = int.tryParse(parts[0]) ?? 0;
  final m = int.tryParse(parts[1]) ?? 0;
  final isPm = h24 >= 12;
  var h12 = h24 % 12;
  if (h12 == 0) {
    h12 = 12;
  }
  final ap = isPm ? 'PM' : 'AM';
  return '${h12.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')} $ap';
}

TimeOfDay parseApiTimeToTimeOfDay(String? raw, {String fallback = '09:00:00'}) {
  final s = raw ?? fallback;
  final parts = s.split(':');
  final h = int.tryParse(parts[0]) ?? 9;
  final m = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
  return TimeOfDay(hour: h, minute: m);
}

String timeOfDayToApi(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';
