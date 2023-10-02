import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel/bloc/hotelinfo_bloc.dart';
import 'package:flutter_hotel/bloc/reserv_bloc.dart';
import 'package:flutter_hotel/bloc/rooms_bloc.dart';
import 'package:flutter_hotel/screens/ListRoomScreen.dart';
import 'package:flutter_hotel/screens/ReserveScreen.dart';
import 'package:local_auth/local_auth.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel',
      theme: ThemeData(
      fontFamily: 'Sfpro'
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
      ),
      home:MultiBlocProvider(
          providers: [
            BlocProvider<ReserveBloc>(
                create: (context) =>ReserveBloc()),
          ],
          child: const ReserveScreen())/*MultiBlocProvider(
        providers: [
          BlocProvider<ArticlesBloc>(
              create: (context) =>ArticlesBloc()),
        ],
        child: CarouselWithIndicatorDemo(),
      ),*/
    );
  }
}

/*class Daa extends StatefulWidget {
  const Daa({Key? key}) : super(key: key);

  @override
  State<Daa> createState() => _DaaState();
}

class _DaaState extends State<Daa> {

  String name = "aaa";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("State");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("change");
  }

  @override
  void didUpdateWidget(covariant Daa oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("update");
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      setState(() {
        name="www";
        print('ooo');
      });
    }, child:Text(name));
  }
}*/



class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ArticlesBloc>();
    final mapData = bloc.state is ArticlesFinishData? (bloc.state as ArticlesFinishData).article :{};
     List<String> imgList = [];
    if(mapData.isNotEmpty){
      imgList = [...mapData['image_urls']];
    }

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
      //  margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width:343,height: 257,),
              ],
            )),
      ),
    ))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white70,
      body:bloc.state is ArticlesFinishData? ListView(children:[
        Container(
         // margin: const EdgeInsets.only(top: 5),
          height: 60,
          decoration:const BoxDecoration(color: Colors.white),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[Text("Отель",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500) ,)]),
        ),
     Container(
         decoration: const BoxDecoration(
             borderRadius:  BorderRadius.vertical(bottom: Radius.circular(12),top: Radius.zero),
           color: Colors.white
         ),
         child: Column(children: [Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
           Container(
             width: 90,
           height: 22,
           margin: const EdgeInsets.only(bottom: 10),
             decoration:const BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(12)),
               color: Colors.white
             ),
             child:  Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: imgList.asMap().entries.map((entry) {
               return GestureDetector(
                 onTap: () => _controller.animateToPage(entry.key),
                 child:
                // Expanded(child:
                 Container(
                   width: 7.0,
                   height: 7.0,
                   margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                   decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: (Theme.of(context).brightness == Brightness.dark
                           ? Colors.white
                           : Colors.black)
                           .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                 )
                // ),
               );
             }).toList(),
           ),),
          ]),
    const SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 30,),
        Container(
     // width: 149,
     // height: 29,
      decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: HexColor.fromHex('#FFC700').withOpacity(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,size:15,color: HexColor.fromHex('#FFA800'),),
          Text(" ${mapData['rating'].toString()}",style: TextStyle(color: HexColor.fromHex('#FFA800'),fontSize: 16),),
          Text(" ${mapData['rating_name']}",style: TextStyle(color: HexColor.fromHex('#FFA800'),fontSize: 16))
        ],),
    )],),
      const SizedBox(height: 10,),
        AboutHotel(data: mapData as Map<String,dynamic> ,),
  ])),
        const SizedBox(height: 5/*,child:ColoredBox(color: Colors.white30,)*/,),
        About(data: mapData as Map<String,dynamic>),
        const SizedBox(height: 5),
       const ToRoom(),
      ]):const Center(child:Text("Waiting, please")),
    );
  }
}

class AboutHotel extends StatelessWidget {
  final Map<String,dynamic> data;
  const AboutHotel({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
           // width: 343,
          //  height: 26,
            child: const Text('Steigenberger Makadi',style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
          ),
          const SizedBox(height: 5,),
        SizedBox(
          //height: 17,
         // width: 343,
          child:GestureDetector(child: Text(data['adress'],style:TextStyle(fontSize: 14, color:HexColor.fromHex('#0D72FF'),fontWeight: FontWeight.w500),),)
        ),
          const SizedBox(height: 5,),
          Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("от ${data['minimal_price'].toString().substring(0,3)} ${data['minimal_price'].toString().substring(3,6)} ₽ ",style:const TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
            Text(data['price_for_it'].toLowerCase(),style:TextStyle(fontSize: 16, color:HexColor.fromHex('#828796'),fontWeight: FontWeight.w400),)
          ],
        ),
         const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  final Map<String,dynamic> data;
  const About({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data!=null?Container(
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.all(Radius.circular(12)),
        color: Colors.white
      ),
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          SizedBox(
            width: 343,
            height: 26,
            child:  const Text("Об отеле",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
          ),
          const SizedBox(height: 15,),
        Column(
          children: [
            ...data["about_the_hotel"]['peculiarities'].map((el){
                return Row(
                    children: [
                      Expanded(child: Text("${el[0]}",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),),),),
                      const SizedBox(width: 5,),
                       Expanded(child: Text("${el[1]}",style:TextStyle(fontSize: 16, color:HexColor.fromHex('#828796'),fontWeight: FontWeight.w500),)),

                    ]);
            })
          ],
        ),
          const SizedBox(height: 10,),
          SizedBox(
            width: 343,
              height: 76,
            child: Text(data["about_the_hotel"]["description"],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),),
       const SizedBox(height: 20,),
         Row(
           children: [
            const Image(image: AssetImage('assets/happy.png')),
           const SizedBox(width: 15,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Text("Удобства",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                 Text("Самое необходимое",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color:HexColor.fromHex('#828796')))
               ],
             ),
       Expanded(child: SizedBox(
         width:MediaQuery.of(context).size.width*0.5,
       ),),
            const Icon(Icons.arrow_forward_ios_outlined,size: 24,),
           ],
         ),
         const SizedBox(height: 15,),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color:HexColor.fromHex('#828796')))
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              const Image(image: AssetImage('assets/tik.png'),),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Что включено",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  Text("Самое необходимое",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color:HexColor.fromHex('#828796')))
                ],
              ),
              Expanded(child: SizedBox(
                width:MediaQuery.of(context).size.width*0.5,
              ),),
              const Icon(Icons.arrow_forward_ios_outlined,size: 24,),
            ],
          ),
          const SizedBox(height: 15,),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color:HexColor.fromHex('#828796')))
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              const Image(image: AssetImage('assets/close.png')),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Что не включено",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  Text("Самое необходимое",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color:HexColor.fromHex('#828796')))
                ],
              ),
              Expanded(child: SizedBox(
                width:MediaQuery.of(context).size.width*0.5,
              ),),
              const Icon(Icons.arrow_forward_ios_outlined,size: 24,),
            ],
          ),
          const SizedBox(height: 30,),
        ],
      ),
    ):const SizedBox();
  }
}

class ToRoom extends StatelessWidget {
  const ToRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius:  BorderRadius.vertical(top: Radius.circular(12),bottom: Radius.zero),
          color: Colors.white
      ),
    padding:const EdgeInsets.all(30),
      child:Row(
        children: [
          Expanded(child:GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>MultiBlocProvider(
                  providers: [
                    BlocProvider<RoomBloc>(
                        create: (context) =>RoomBloc()),
                  ],
                  child: const ListRoom()),));
    },       child:Container(
             width: 343,
             height: 48,
             alignment: Alignment.center,
             decoration: BoxDecoration(
                 color:HexColor.fromHex('#0D72FF'),
                 borderRadius:const BorderRadius.all(Radius.circular(15))
             ),
            child:const Text("К выбору номера",textAlign:TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white)),
          ))),
        ],
      ),
    );
  }
}

