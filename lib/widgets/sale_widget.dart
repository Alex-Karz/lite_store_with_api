import 'package:flutter/material.dart';

class SaleWidget extends StatelessWidget {
  String? item;
  SaleWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      width: double.infinity,
      height: size.height * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 126, 19, 148),
              Color.fromARGB(204, 176, 150, 245),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color.fromARGB(226, 171, 151, 224),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Hot offer!',
                    style: TextStyle(color: Colors.amber, fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text('50%\nOFF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(width: double.infinity, fit: BoxFit.cover, 'assets/images/item-$item.png'),
            ),
          )
        ],
      ),
    );
  }
}
