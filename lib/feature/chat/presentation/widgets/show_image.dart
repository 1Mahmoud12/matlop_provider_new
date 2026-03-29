import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/seemore_seeless_widget.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({super.key, this.image, this.text, this.imageList});
  final String? image;
  final String? text;
  final List<String>? imageList;
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: Colors.white,
      // ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (widget.imageList != null)
              Expanded(
                child: PageView.builder(
                  itemCount: widget.imageList!.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.imageList![index],
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.contain,
                    );
                  },
                ),
              )
            else
              Center(
                child: CachedNetworkImage(
                  imageUrl: widget.image!,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 1.5,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.text != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SeeMoreSeeLessWidget(
                            text: widget.text!,
                            isExpanded: _isExpanded,
                            onTap: _toggleExpand,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
