import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  final int? raterCount;
  const Stars({super.key, required this.rating, this.raterCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(rating.toString(),

        style: TextStyle(
          fontSize: 12),),
        SizedBox(width: 1,),
        RatingBarIndicator(
          direction: Axis.horizontal,
            itemCount: 5,
            rating: rating,
            itemSize: 15,
            itemBuilder: (context,_){
              return const Icon(Icons.star, color: GlobalVariable.secondaryColor);
            }),
        SizedBox(width: 4,),
        Text(raterCount.toString(),
        style: TextStyle(
          color: Colors.teal,
          fontSize: 12
        ),)
      ],
    );
  }
}
