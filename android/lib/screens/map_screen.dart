import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String titulo;
  final String thumbnail;
  const MapScreen({Key key, @required this.titulo, @required this.thumbnail}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _mapController = new Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  String enderecoEnvio;
  CameraPosition _posicaoCamera = CameraPosition(
    target: LatLng(-4.936120, -37.975355),
    zoom: 20
  );

  _onMapCreated(GoogleMapController googleMapController){
    _mapController.complete(googleMapController);
  }

  _recuperarLocalizacaoAtual() async{
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    setState(() {
      _posicaoCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18
      );
      _movimentarCamera();
    });
  }

  _movimentarCamera() async{
    GoogleMapController googleMapController = await _mapController.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        _posicaoCamera
      )
    );
  }

  _adicionarMarcador( LatLng latLng ) async {

    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if( listaEnderecos != null && listaEnderecos.length > 0 ){

      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;

      Marker marcador = Marker(
          markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(
              title: rua
          ),
      );
      if(endereco.thoroughfare != null)
        enderecoEnvio = endereco.thoroughfare;
      if(endereco.subLocality != null && endereco.thoroughfare != null)
        enderecoEnvio += ', ' + endereco.subLocality;
      else if(endereco.subLocality != null)
        enderecoEnvio += endereco.subLocality;
      if(endereco.subAdministrativeArea != null && endereco.subLocality != null)
        enderecoEnvio += ', ' + endereco.subAdministrativeArea;
      else if(endereco.subAdministrativeArea != null)
        enderecoEnvio += endereco.subAdministrativeArea;
      setState(() {
        enderecoEnvio;
        _markers.add( marcador );
        _processandoCompra(enderecoEnvio);
      });
    }

  }

  Future<void> _processandoCompra(String destinatario){
    return showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Compra feita! Aguarde o processamento."),
          actions: [
            Container(
              width: 500,
              height: 50,
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: RaisedButton(
                color: Color(0xFFEC1D24),
                child: Text("Comprar novamente"),
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                    Text(widget.titulo),
                    Padding(padding: EdgeInsets.only(top:5, bottom: 5)),
                    Text("Endereço de entrega selecionado:"),
                    Text(enderecoEnvio),
                    Padding(padding: EdgeInsets.only(top:5, bottom: 5)),
                    Container(
                      width: 200.0,
                      height: 300.0,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(widget.thumbnail)),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color(0xFFEC1D24),
                      ),
                    ),
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

  @override
  void initState() {
    super.initState();
    _recuperarLocalizacaoAtual();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione o endereço de entrega"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _posicaoCamera,
        onMapCreated: _onMapCreated,
        markers: _markers,
        onLongPress: _adicionarMarcador
      )
    );
  }
}