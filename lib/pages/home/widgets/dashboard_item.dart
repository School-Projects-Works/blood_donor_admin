import 'package:flutter/material.dart';

class DashboardItem extends StatefulWidget {
  const DashboardItem(
      {super.key, this.title, this.value, this.color, this.icon});
  final String? title;
  final double? value;
  final Color? color;
  final IconData? icon;

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return InkWell(
        onTap: () {},
        onHover: (value) {
          if (value) {
            setState(() {
              isHover = true;
            });
          } else {
            setState(() {
              isHover = false;
            });
          }
        },
        child: Container(
          width: size.maxWidth > 800 ? size.maxWidth * .3 - 20 : size.maxWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:isHover?Colors.white: widget.color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: widget.color!, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  widget.icon,
                  color: isHover ? widget.color : Colors.white,
                ),
                Text(
                  widget.title!,
                  style:  TextStyle(
                      color: isHover ? widget.color : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.value.toString(),
              style:  TextStyle(
               color: isHover ? widget.color : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          

          ]),
        ),
      );
    });
  }
}
