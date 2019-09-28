import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center/models/kajianModel.dart';

class DetailKajian extends StatelessWidget {
  final kajianModel model;
  DetailKajian(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[],
        ),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Hero(
              tag: model.tag.toString(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      model.gambar.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
