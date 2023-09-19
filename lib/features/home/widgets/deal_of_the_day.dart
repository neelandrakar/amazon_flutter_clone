import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  String dealOfTheDay =
      'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2014%2F04%2Fnike-unveils-2014-mercurial-superfly-0.jpg?w=960&cbr=1&q=90&fit=max';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Text(
            'Deal of the day',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Image.network(
          dealOfTheDay,
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15,top: 2),
          alignment: Alignment.topLeft,
          child: Text(
          "₹2999",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500

            ),
          ),


        ),
        Container(
          padding: const EdgeInsets.only(left: 15,right: 30,top: 2),
          alignment: Alignment.topLeft,
          child: const Text(
            'Nike Unveils the Flyknit Mercurial Superfly IV | Hypebeast',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network('https://www.soccerbible.com/media/16961/nike-superfly-tech-craft-img-tab.jpg',fit: BoxFit.fitWidth,width: 100,height: 100),
              Image.network('https://www.soccerbible.com/media/7639/nike_merc_superfly_low_img_tab.jpg',fit: BoxFit.fitWidth,width: 100,height: 100),
              Image.network('https://www.soccerbible.com/media/2957/superfly-sketches-img-tab.jpg',fit: BoxFit.fitWidth,width: 100,height: 100),
              Image.network('https://www.soccerbible.com/media/2842/superfly-launch-event-img-tab.jpg',fit: BoxFit.fitWidth,width: 100,height: 100),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
              decoration: TextDecoration.underline
            ),
          ),
        )
      ],
    );
  }
}
