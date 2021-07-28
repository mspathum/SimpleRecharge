import 'package:flutter/material.dart';

class SimCardWidget extends StatelessWidget {
  final String slotNumber;
  final String displayName;
  final Function onCardTapperd;

  SimCardWidget(this.slotNumber, this.displayName, this.onCardTapperd);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onCardTapperd(displayName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        color: Colors.white,
        elevation: 0.0,
        child: Container(
          height: deviceHeight / 4.5,
          width: deviceWidth / 2.5,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sim_card,
                size: 32.0,
              ),
              SizedBox(height: 0.5),
              Text(
                "${this.slotNumber}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "${this.displayName}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
