import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final title;
  final price;
  final image;
  final index;
  const ProductCard(
      {super.key,
      required this.index,
      required this.title,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 25),
        decoration: BoxDecoration(
            // image: (index % 2 == 0)
            //     ? DecorationImage(
            //         image: AssetImage('assets/images/final_bg_card.png'),
            //         fit: BoxFit.cover)
            //     : null,
            border: Border.all(
                color: Color.fromARGB(255, 25, 25, 25),
                width: (index % 2 == 1) ? 2 : 0),
            color:
                index % 2 == 1 ? Color(0x41404e) : Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: (index % 2 == 1) ? Colors.black : Colors.white),
              maxLines: 2,
            ),
            SizedBox(height: 5),
            Text("₹${price.toString()}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: (index % 2 == 1) ? Colors.black : Colors.white)),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage(image),
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
