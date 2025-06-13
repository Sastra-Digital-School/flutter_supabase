class PopularItem {
  final String id;
  final String name;
  final String imagePath;
  final String? signedUrl;

  PopularItem({
    required this.id,
    required this.name,
    required this.imagePath,
    this.signedUrl,
  });

  factory PopularItem.fromMap(Map<String, dynamic> map) {
    return PopularItem(
      id: map['id'],
      name: map['name'],
      imagePath: map['image'],
      signedUrl: null,
    );
  }

  PopularItem copyWithSignedUrl(String signedUrl) {
    return PopularItem(
      id: id,
      name: name,
      imagePath: imagePath,
      signedUrl: signedUrl,
    );
  }
}
