enum ItemType { news, internship, scholarship, accommodation, accommodationUnit}

String itemTypeToString(ItemType type) {
  switch (type) {
    case ItemType.news:
      return 'News';
    case ItemType.internship:
      return 'Internship';
    case ItemType.scholarship:
      return 'Scholarship';
    case ItemType.accommodation:
      return 'Accommodation';
    case ItemType.accommodationUnit:
      return 'Accommodation unit';
  }
}

extension ItemTypeExtension on ItemType {
  String toShortString() {
    return toString().split('.').last;
  }
}