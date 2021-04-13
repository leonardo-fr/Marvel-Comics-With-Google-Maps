import 'dart:convert';
import 'package:commic_geek/model/comic_model.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';

class ResponseRepository{
  Dio dio = new Dio();
  final String url = "https://gateway.marvel.com:443/v1/public/comics";
  //final String hashKey = "a4f352b27555bee02bf0710b8dde7b8afed09aa0ac3e2b8797f18428379daa9dccf4a687";

  Future<ComicModel> buscarComics(int pagina, String busca) async{
    var timestamp = new DateTime.now().millisecondsSinceEpoch.toString();
    final hash = gerarMD5(timestamp);
    Map<String, dynamic> queryParams = {
      'titleStartsWith': '$busca',
      'limit': '10',
      'offset': '$pagina',
      'apikey': 'e01fb038b67cc6d7b0031c6938020d18',
      'hash': '$hash',
      'ts': '$timestamp',
        //padrao: 15
      //pagina
    };

    String queryString = Uri(queryParameters: queryParams).query;
    //print(url + '?' + queryString);
    try{
      print("Request: " + url + '?' + queryString);
      dynamic response = await dio.get(url + '?' + queryString);
      ComicModel dados = ComicModel.fromJson(response.data);
      return dados;
    }catch(e){
      print(e);
    }
  }

}

String gerarMD5(String timestamp) {
  //String keys ='fed09aa0ac3e2b8797f18428379daa9dccf4a687' + 'a4f352b27555bee02bf0710b8dde7b8a';
  String keys ='b068f3ee7a9e32eb4430246271a25afadf8408a6' + 'e01fb038b67cc6d7b0031c6938020d18';
  var content = new Utf8Encoder().convert(timestamp + keys);
   var md5 = crypto.md5;
  var digest = md5.convert(content);
  return digest.toString();
}