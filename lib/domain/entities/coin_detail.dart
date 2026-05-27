import 'package:equatable/equatable.dart';

import 'coin_summary.dart';

/// Expanded coin facts for the detail screen.
final class CoinDetail extends Equatable {
  const CoinDetail({
    required this.summary,
    this.descriptions = const {},
    this.hashingAlgorithm,
    this.categories = const [],
    this.volumeUsd24h,
    this.athUsd,
    this.atlUsd,
    this.athChangePercentage,
    this.atlChangePercentage,
    this.circulatingSupply,
    this.maxSupply,
  });

  final CoinSummary summary;
  final Map<String, String> descriptions;
  final String? hashingAlgorithm;
  final List<String> categories;
  final double? volumeUsd24h;
  final double? athUsd;
  final double? atlUsd;
  final double? athChangePercentage;
  final double? atlChangePercentage;
  final double? circulatingSupply;
  final double? maxSupply;

  String? descriptionFor(String languageCode) {
    final localized = descriptions[languageCode];
    if (localized != null && localized.trim().isNotEmpty) return localized;

    final english = descriptions['en'];
    if (english != null && english.trim().isNotEmpty) return english;

    for (final value in descriptions.values) {
      if (value.trim().isNotEmpty) return value;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    summary,
    descriptions,
    hashingAlgorithm,
    categories,
    volumeUsd24h,
    athUsd,
    atlUsd,
    athChangePercentage,
    atlChangePercentage,
    circulatingSupply,
    maxSupply,
  ];
}
