import 'package:flutter/material.dart';
import 'package:movies_app/data/entity/movie.dart';

class MovieDetail extends StatefulWidget {
  Movie movie;


  MovieDetail({required this.movie});

 // const MovieDetail({super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.name)),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/${widget.movie.image}", fit: BoxFit.cover,
            ),
            Text("${widget.movie.price} ₺", style: TextStyle(fontSize: 28),)
          ],
        )
      )
    );
  }
}
