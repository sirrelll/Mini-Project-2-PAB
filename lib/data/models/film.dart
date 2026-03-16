class Film {
  final int? id;
  String judul;
  String genre;
  String sutradara;

  Film({
    this.id,
    required this.judul,
    required this.genre,
    required this.sutradara,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      judul: json['judul'],
      genre: json['genre'],
      sutradara: json['sutradara'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'genre': genre,
      'sutradara': sutradara,
    };
  }
}