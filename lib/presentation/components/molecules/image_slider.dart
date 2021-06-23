import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({required this.images});
  final List<String> images;
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    // 画像が1枚以上あればIndicator表示
    return widget.images.length == 1
        ? _buildImageSlider()
        : Stack(
            children: [
              _buildImageSlider(),
              _buildCircleIndicator(),
            ],
          );
  }

  Widget _buildImageSlider() {
    return Card(
      // 角丸設定
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // 画像が四角の角丸からはみ出さない設定
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      child: SizedBox(
        // 画像表示領域の高さ
        height: 240,
        // 画像が1枚以上あればPageViewに無限スクロール設定
        child: widget.images.length == 1
            ? PageView.builder(
                itemCount: widget.images.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildImageView(context, widget.images[index]),
              )
            : PageView.builder(
                controller: PageController(
                    initialPage: initialPageCount(widget.images.length)),
                itemBuilder: (BuildContext context, int index) =>
                    _buildImageView(
                        context, widget.images[index % widget.images.length]),
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index % widget.images.length;
                },
              ),
      ),
    );
  }

  Widget _buildCircleIndicator() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 8,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CirclePageIndicator(
          dotColor: Colors.grey,
          selectedDotColor: Colors.white,
          selectedSize: 9,
          itemCount: widget.images.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  Widget _buildImageView(BuildContext context, String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, dynamic error) =>
          const Center(child: Icon(Icons.error)),
      fit: BoxFit.cover,
    );
  }

  int initialPageCount(int imageCount) {
    if (imageCount % 9 == 0) {
      return 999;
    }
    if (imageCount % 7 == 0) {
      return 1001;
    }
    if (imageCount % 3 == 0) {
      return 1002;
    }
    return 1000;
  }
}
