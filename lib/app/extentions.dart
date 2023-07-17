extension NoNullInt on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NoNullDouble on double? {
  double orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NoNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}
