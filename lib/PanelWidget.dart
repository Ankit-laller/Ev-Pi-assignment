import 'package:ankit_assignment/String.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_player/video_player.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;


  const PanelWidget(
      {super.key, required this.controller, required this.panelController});

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: widget.controller,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 12,
        ),
        draghandle(),
        SizedBox(
          height:30,
        ),
        Container(
          height: 110,
          width: 90,
          child: ListView.builder(

              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              itemCount: 10, // Number of horizontal grid items
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/home.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20.0),),
                    ),
                    // child: Image.asset("assets/image.jpg",
                    // fit: BoxFit.cover,
                    // width: 80,
                    // height: 100,),
                ));
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(Strings().des, style: TextStyle(fontSize: 15),),
        ),
        Center(child: TextButton( onPressed: (){}, child: Text("Read More"),),),

        Stack(

          children: [
            Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24)
                ),
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 80, horizontal: 80),
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: !isPlaying? Icon(Icons.play_circle, size: 50,):
                  Icon(Icons.pause_circle, size: 50,),
                  onPressed: (){
                    setState(() {
                      // If the video is playing, pause it.
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                        isPlaying = false;
                      } else {
                        // If the video is paused, play it.
                        _controller.play();
                        isPlaying = true;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Top Sights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
                margin: EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(20.0),),
                  ),
                  // child: Image.asset("assets/image.jpg",
                  // fit: BoxFit.cover,
                  // width: 80,
                  // height: 100,),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Eiffel Tower", style: TextStyle(fontSize: 16),),
                    Text("The Eiffel Tower has had\n a colorful history—literally")
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget draghandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),

          ),
        ),
        onTap: () {
          widget.panelController.isPanelOpen
              ? widget.panelController.close()
              : widget.panelController.open();
        },
      );
}
