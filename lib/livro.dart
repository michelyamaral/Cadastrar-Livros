class Livro {
  final int? id;
  final String titulo;
  final String autor;
  final String editora;
  final String lido;

  const Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.editora,
    required this.lido,
  });

  factory Livro.fromMap(Map<String, dynamic> json) => new Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      editora: json['editora'],
      lido: json['lido']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'editora': editora,
      'lido': lido
    };
  }
}
