
import 'dart:convert';
import 'dart:io';
import '../model/cidade.dart';
import 'package:http/http.dart';

class CidadeService {
  static const _baseUrl = 'http://cloud.colegiomaterdei.com.br:8090/cidades';

  Future<List<Cidade>> findCidades() async {
    final uri = Uri.parse(_baseUrl);
    final Response response = await get(uri);
    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception();
    }
    final decodedBody = json.decode(response.body) as List;
    return decodedBody
        .map((e) => Cidade.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveCidade(Cidade cidade) async {
    final uri = Uri.parse(_baseUrl);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final body = cidade.toJson();
    final Response response = await post(uri, body: json.encode(body), headers: headers);
    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception();
    }
  }

  Future<void> deleteCidade(Cidade cidade) async {
    final uri = Uri.parse('$_baseUrl/${cidade.codigo}');
    final Response response = await delete(uri);
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}