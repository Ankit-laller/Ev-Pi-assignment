
import 'package:flutter/material.dart';

class ButtonExpandedWidget extends StatelessWidget {
  const ButtonExpandedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        shape: BoxShape.rectangle,
        color: Colors.blueAccent[100],
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Icon(Icons.flight_takeoff_rounded, size: 40,),
          SizedBox(width: 5,),
          Text("SEARCH FLIGHTS", style: TextStyle(color: Colors.white, fontSize: 20),),
          SizedBox(width: 14,),
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
        ],
      ),
    );
  }
}
