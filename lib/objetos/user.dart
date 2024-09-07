import 'package:cint/components/post_oferta.dart';
import 'package:cint/objetos/posts.dart';
import 'package:cint/repositorys/user.repository.dart';

class Usuario {
  // Variáveis estáticas que compartilham o estado entre todas as instâncias
  static String _id = '';
  static String _nome = '';
  static int _titulo = 0;
  static num _nota = 0;
  static num _meta = 0;
  static String _endereco = '';
  static String? _foto;
  static List<PostOferta> _posts = [];
  static String _email = '';

  // Construtor padrão que permite modificar o estado
  Usuario({
    String? id,
    String? nome,
    int? titulo,
    num? nota,
    num? meta,
    String? endereco,
    String? foto,
    List<PostOferta>? posts,
    String? email,
  }) {
    _id = id ?? _id;
    _nome = nome ?? _nome;
    _titulo = titulo ?? _titulo;
    _nota = nota ?? _nota;
    _meta = meta ?? _meta;
    _endereco = endereco ?? _endereco;
    _foto = foto ?? _foto;
    _posts = posts ?? _posts;
    _email = email ?? _email;
  }

  // Getters para acessar as propriedades estáticas
  String get id => _id;
  String get nome => _nome;
  int get titulo => _titulo;
  num get nota => _nota;
  num get meta => _meta;
  String get endereco => _endereco;
  String? get foto => _foto;
  List<PostOferta> get posts => _posts;
  String get email => _email;

  // Método para atualizar os valores a partir de um JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      titulo: json['titulo'],
      nota: json['nota'],
      meta: json['meta'],
      endereco: json['endereco'],
      foto: json['foto'],
      posts: [],
      email: json['user_email'],
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

  // Método para atualização manual
  void update({
    String? id,
    String? nome,
    int? titulo,
    num? nota,
    num? meta,
    String? endereco,
    String? foto,
    List<PostOferta>? posts,
    String? email,
  }) {
    _id = id ?? _id;
    _nome = nome ?? _nome;
    _titulo = titulo ?? _titulo;
    _nota = nota ?? _nota;
    _meta = meta ?? _meta;
    _endereco = endereco ?? _endereco;
    _foto = foto ?? _foto;
    _posts = posts ?? _posts;
    _email = email ?? _email;
  }
}
