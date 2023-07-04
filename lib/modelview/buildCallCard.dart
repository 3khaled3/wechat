// ignore_for_file: camel_case_types, file_names
import 'package:flutter/material.dart';
import 'callcard.dart';
class buildCallCardList extends StatefulWidget {
  const buildCallCardList({super.key});
  @override
  State<buildCallCardList> createState() => _buildCallCardListState();
}
class _buildCallCardListState extends State<buildCallCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xff161c16),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => const CallCard(),
        ));
  }
}
