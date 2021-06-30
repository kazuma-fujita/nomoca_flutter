import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nomoca_flutter/presentation/components/atoms/parallax_card.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ImagesSlider extends StatefulWidget {
  const ImagesSlider({required this.images, this.isParallax = false});

  final List<String> images;
  final bool isParallax;

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.isParallax
            ? ParallaxCard(
                builder: _buildParallaxImageSlider,
              )
            : _buildImagesSlider(),
        // 画像が1枚以上あればIndicator表示
        if (widget.images.length > 1) _buildCircleIndicator(),
      ],
    );
  }

  Widget _buildParallaxImageSlider(GlobalKey backgroundImageKey) {
    return SizedBox(
      key: backgroundImageKey,
      // 画像表示領域の高さ
      height: 240,
      child: _buildImagesSlider(),
    );
  }

  Widget _buildImagesSlider() {
    final _pageController = PageController();
    // PageViewスクロール時の背景にグラデーションのエフェクトをかける
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        // グラデーションエフェクト
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.6, 0.95],
            ),
          ),
          child: child,
        );
      },
      child: widget.images.length == 1
          ? PageView.builder(
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildImageView(context, widget.images[index]),
            )
          : PageView.builder(
              controller: PageController(
                initialPage: initialPageCount(widget.images.length),
              ),
              itemBuilder: (BuildContext context, int index) => _buildImageView(
                  context, widget.images[index % widget.images.length]),
              onPageChanged: (int index) {
                _currentPageNotifier.value = index % widget.images.length;
              },
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
