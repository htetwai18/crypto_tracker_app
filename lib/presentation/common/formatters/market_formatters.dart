import 'package:intl/intl.dart';

String formatUsd(num? amount) {
  if (amount == null) return '—';
  return NumberFormat.simpleCurrency(name: 'USD').format(amount);
}

String formatCompactUsd(num? amount) {
  if (amount == null) return '—';
  return NumberFormat.compactCurrency(
    symbol: r'$',
    decimalDigits: 2,
  ).format(amount);
}

String formatCoinPrice(num? amount) {
  if (amount == null) return '—';
  if (amount >= 1000) {
    return NumberFormat('#,##0.00', 'en_US').format(amount).prependDollar();
  }
  if (amount >= 1) {
    return NumberFormat('#,##0.00', 'en_US').format(amount).prependDollar();
  }
  if (amount >= 0.0001) {
    return '\$${amount.toStringAsFixed(6)}';
  }
  return '\$${amount.toStringAsFixed(8)}';
}

String formatBtcPrice(num? amount) {
  if (amount == null) return '—';
  if (amount >= 1) {
    return '${NumberFormat('#,##0.########', 'en_US').format(amount)} BTC';
  }
  if (amount >= 0.0001) {
    return '${amount.toStringAsFixed(6)} BTC';
  }
  return '${amount.toStringAsFixed(8)} BTC';
}

String formatPercentChange(num? value) {
  if (value == null) return '—';
  final sign = value >= 0 ? '+' : '';
  return '$sign${value.toStringAsFixed(2)}%';
}

String formatSupplyAmount(num? amount, String symbol) {
  if (amount == null) return '—';
  final compact = NumberFormat.compact().format(amount);
  return '$compact ${symbol.toUpperCase()}';
}

extension _DollarPrefix on String {
  String prependDollar() => '\$$this';
}
