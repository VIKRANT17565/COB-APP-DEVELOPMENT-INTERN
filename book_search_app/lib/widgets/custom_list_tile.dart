import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String bookName;
  final String bookAuthor;
  final String bookImage;

  const CustomListTile({
    super.key,
    required this.bookName,
    required this.bookAuthor,
    required this.bookImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: bookImage,
            width: 70,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookName,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  bookAuthor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
