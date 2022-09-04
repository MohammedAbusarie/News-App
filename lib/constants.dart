//news enum

enum NEWS_CATEGORIES { sports, science,technology }

extension ParseToString on NEWS_CATEGORIES {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
