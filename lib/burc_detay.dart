import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/burc_liste.dart';
import 'model/burc.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  int index;
  @override
  _BurcDetayState createState() => _BurcDetayState();

  BurcDetay(this.index);
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color dominantRenk;
  PaletteGenerator paletteGenerator;

  void baskinRengiBul()
  {
    Future<PaletteGenerator> fpaletGenerator = PaletteGenerator.fromImageProvider(AssetImage("images/"+secilenBurc.burcBuyukResim));
    fpaletGenerator.then((value) {
      paletteGenerator= value;
      debugPrint("Secilen renk: "+ paletteGenerator.vibrantColor.color.toString());
      setState(() {
        dominantRenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secilenBurc = BurcListesi.tumBurclar[widget.index];
      baskinRengiBul();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/" + secilenBurc.burcBuyukResim),
              centerTitle: true,
              title: Text(secilenBurc.burcAdi + " Burcu ve Özellikleri"),
            ),
            backgroundColor: dominantRenk == null? Colors.blue:dominantRenk,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Text(
                  secilenBurc.burcDetay,
                  style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
