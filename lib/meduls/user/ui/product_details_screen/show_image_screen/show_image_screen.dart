import 'package:flutter/material.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImageScreen extends StatelessWidget {
  final List<String> images;
  const ShowImageScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      fit: StackFit.expand,
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(ApiConstants.imageUrl(images[index])),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
            );
          },
          itemCount: images.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
        ),
        Positioned(
            right: 30,
            top: 50,
            child: GestureDetector(
              onTap: () {
                pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    ));
  }
}
