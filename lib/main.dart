import 'package:ankit_assignment/widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'PanelWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isScrollUp = false;
  final panelController= PanelController();


  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height* 0.9;
    final panelHeightClose = MediaQuery.of(context).size.height *0.2;
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.arrow_downward_outlined, color: Colors.white,),
          title: isScrollUp?const ListTile(
            leading: Text(""),
            title: Text("Eiffel Tower", style: TextStyle(color: Colors.white,
            fontSize: 18),),
            subtitle: Row(
              children: [Icon(Icons.location_on_outlined, size: 16,),
              Text("Paris, France", style: TextStyle(color: Colors.white))],
            ),
            trailing: Text(""),
          ):const Center(child: Text("",
              style: TextStyle(color: Colors.white))),
          actions: const [
            Icon(Icons.favorite_outline, color: Colors.white,),
            SizedBox(width: 10,)
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),

        body: Stack(
          children: [
            SlidingUpPanel(
              controller: panelController,
              body: Stack(
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/home.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 180),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green
                              ),
                              child: Center(child: Text("ON SALE", style: TextStyle(color: Colors.white),)),
                            ),
                            Text("Eifell Tower", style: TextStyle(color: Colors.white,
                            fontSize: 24, fontWeight: FontWeight.bold)),
                            Text("Paris, France", style: TextStyle(color: Colors.white,
                            fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),

              parallaxEnabled: true,
              minHeight: panelHeightClose,
              maxHeight: panelHeightOpen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),

              onPanelClosed: (){
                setState(() {
                  isScrollUp = false;
                });
              },
              onPanelOpened: (){
                setState(() {
                  isScrollUp = true;
                });
              },
              panelBuilder: (controller)=> PanelWidget(
                controller :controller,panelController: panelController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: isScrollUp? const ButtonExpandedWidget(): FloatingActionButton(
                  backgroundColor: Colors.blueAccent[100],
                  onPressed: (){},
                  child: Icon(Icons.flight_takeoff_rounded, size: 40,),),
              ),
            ),

          ],
        )
    );
  }
}
