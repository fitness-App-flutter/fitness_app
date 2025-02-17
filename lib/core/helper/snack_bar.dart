import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, massage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));
}

void ShowDialog(BuildContext context, massage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const SizedBox(
                        height: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Success',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Color(0xff626ae7)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          massage,
                          style: TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -30,
                child: CircleAvatar(
                  backgroundColor: Color(0xff626ae7),
                  maxRadius: 32,
                  child: Card(
                    color: Color(0xff626ae7),
                    elevation:16,
                    shadowColor: Color(0xff626ae7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: const Icon(Icons.check,color: Colors.white,size: 64,),
                  ),
                ),
              ),
            ],
          ));
    },
  );
}
