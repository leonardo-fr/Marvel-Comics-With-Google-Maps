
import 'package:commic_geek/repository/response_repository.dart';
import 'package:commic_geek/screens/map_screen.dart';
import 'package:flutter/material.dart';

import 'model/comic_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = new TextEditingController();
  ComicModel comics = new ComicModel();
  List<String> imagens = new List<String>();
  List<String> titulos = new List<String>();
  List<String> descricoes = new List<String>();
  int paginaAtual = 0;
  int tamanhoPagina = 0;
  bool carregandoComics = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> buscarQuadrinhos({@required bool novaBusca}) async{
    try{
      if(novaBusca == true){
        setState(() {
          imagens.clear();
          titulos.clear();
          descricoes.clear();
          paginaAtual = 0;
          tamanhoPagina = 0;
        });
      }
      comics = await ResponseRepository().buscarComics(paginaAtual, _textController.text); 
      tamanhoPagina = comics.data.results.length;
      print("tamanho: "+ tamanhoPagina.toString());
      if(comics.status != null && paginaAtual < tamanhoPagina)
        paginaAtual++;
      
      if(paginaAtual <= tamanhoPagina){
        for(int i = 0; i < comics.data.results.length; i++){
          if(comics.data.results[i].title.toString().contains("Marvel Previews") == false &&
          comics.data.results[i].thumbnail.toString().contains("image_not_available") == false){
            imagens.add(comics.data.results[i].thumbnail['path'].toString() + '.jpg');
            titulos.add(comics.data.results[i].title);

            comics.data.results[i].description != null ?
            descricoes.add(comics.data.results[i].description.toString()) :
            descricoes.add('descrição não cadastrada');
          }
        }
      }
      setState(() => titulos);
    }catch(err){
      print(err);
    }
  }  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _myAppBar(){
    return AppBar(
      backgroundColor: Color(0xFFEC1D24),
      automaticallyImplyLeading: false,
      title: Container(
        color: Colors.transparent,
        child: TextField(
          controller: _textController,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
          decoration: InputDecoration(
            hintText: 'Digite para pesquisar',
            labelStyle: TextStyle(
              color: Colors.white
            ),
            hintStyle: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w400
            ),
          ),
          
          onChanged: (_){
            buscarQuadrinhos(novaBusca: true);
          },
        ),
      )
    );
  }

  Future<void> _detalhesSelecao(BuildContext context,int index){
    return showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(titulos[index]),
          actions: [
            Container(
              width: 500,
              height: 50,
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: RaisedButton(
                color: Color(0xFFEC1D24),
                child: Text("Envie-me"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MapScreen(titulo: titulos[index], thumbnail: imagens[index]))
                  );
                },
              ),
            ),
            
          ],
          content: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
              color: Colors.grey[100],
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300.0,
                      height: 400.0,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(imagens[index])),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color(0xFFEC1D24),
                      ),
                    ),
                    Text("Descrição: ${descricoes[index]}"),
                  ],
                ),
                ),
              ),
            )
          )
        );
      }
    );
  }

  Widget _itemList(int index){
    return GestureDetector(
      onTap: (){
        _detalhesSelecao(context, index);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 1),
        child:
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            margin: EdgeInsets.all(4),
            child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(imagens[index])),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFEC1D24),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Column(
                    children: [
                      Container(
                        width: 250,
                        height: 90,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(5),
                          child: Wrap(
                            children: [
                              Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${titulos[index]}',
                                textAlign: TextAlign.start,
                                style: TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize:  16
                                ),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 2,
                              ),
                              Padding(padding: EdgeInsets.only(top:2)),
                                Text(
                                'Descrição: ${descricoes[index]}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                ),
                                overflow: TextOverflow.fade,
                                softWrap:true,
                                maxLines: 3,
                              ),
                              Padding(padding: EdgeInsets.only(top:4)),
                              
                            ],
                          )
                            ],
                          ),
                      ),
                      RaisedButton(
                        color: Color(0xFFEC1D24),
                        child: Text(
                          "Envie-me",
                          style: TextStyle(
                            color: Colors.white
                          )
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MapScreen(titulo: titulos[index], thumbnail: imagens[index]))
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
                ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _myAppBar(),
      body: titulos.length > 0 ?
      ListView.builder(
              itemCount: titulos.length,
              itemBuilder: (BuildContext context, index){
                if(index == titulos.length-1)
                  return Column(
                    children: [
                      _itemList(index),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          height: 30,
                          width: 180,
                          child: ElevatedButton(
                            onPressed: (){
                              paginaAtual++;
                              buscarQuadrinhos(novaBusca: false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Carregar mais"),
                                Padding(padding: EdgeInsets.only(left: 5)),
                                Icon(Icons.add)
                              ],
                            )
                          )
                        )
                      )
                    ],
                  );
                return _itemList(index);
              }
            ) :
            Container(
              alignment: Alignment.center,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bem vindo ao Comic Geek Shopping!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFEC1D24)
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:5)),
                Text("(Pesquise um quadrinho para comprar)")
              ],
            ),
            )
        
    );
  }
}