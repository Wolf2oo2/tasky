import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomSvgPictureWidget extends StatelessWidget {
  const CustomSvgPictureWidget({super.key,required this.path, this.withOutFilter=true,});
final String path;
final bool withOutFilter;
  @override
  Widget build(BuildContext context) {
    return  SvgPicture.asset(
      path,

      colorFilter: withOutFilter?ColorFilter.mode(
        Theme.of(context).colorScheme.secondary,
        BlendMode.srcIn,
      ):null,
    );
  }
}
