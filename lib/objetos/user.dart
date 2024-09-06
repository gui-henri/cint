import 'package:cint/components/post_oferta.dart';

class Usuario {
  final String id;
  final String nome;
  final int titulo;
  final num nota;
  final num meta;
  final String endereco;
  final String? foto;
  final List<PostOferta> posts;
  final String email;

  Usuario(
    this.id,
    this.titulo,
    this.meta,
    this.endereco,
    {
    required this.nome,
    required this.nota,
    required this.foto,
    required this.posts,
    required this.email,
  });

  // Construtor para criar uma instância de Usuario a partir de um JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      json['id'],
      json['titulo'],
      json['endereco'],
      json['meta'],
      nome: json['nome'],
      nota: json['nota'],
      foto: json['foto'],
      posts: json['posts'],
      email: json['user_email']
    );
  }

   // Método para converter uma instância de Usuario de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'titulo': titulo,
      'nota': nota,
      'endereco': endereco,
      'meta': meta,
      'foto': foto,
      'posts': posts,
      'user_email': email
    };
  }

   // Método para criar a instancia de Usuario convertida para JSON
  Map<String, dynamic> toFirstJson() {
    return {
      'id': id,
      'nome': nome,
      'titulo': titulo,
      'nota': nota,
      'endereco': endereco,
      'meta': meta,
      'foto': foto,
      'posts': posts,
      'user_email': email
    };
  }
}