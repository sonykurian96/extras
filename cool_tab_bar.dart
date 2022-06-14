import 'package:flutter/material.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _progress;

  bool isIndex0 = true;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            // call `build` on animation progress
            setState(() {});
          });

    _progress =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (_isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 55, 55),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Material(
          color: Color.fromARGB(255, 58, 55, 55),
          child: Card(
            elevation: 20,
            color: Colors.black87,
            child: TabBar(
              onTap: (value) {
                if (value == 0) {
                  setState(() {
                    isIndex0 = true;
                  });
                } else {
                  setState(() {
                    isIndex0 = false;
                  });
                }
                animate();
              },
              tabs: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isIndex0 ?Colors.white70 : Colors.transparent,
                        offset: Offset(0, 1),
                        blurRadius: 50,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Tab(
                        icon: SimpleAnimatedIcon(
                          startIcon: Icons.cloud_download_sharp,
                          endIcon: Icons.refresh,
                          progress: _progress,
                          transitions: [
                            Transitions.zoom_in,
                            Transitions.rotate_ccw
                          ],
                        ),
                        text: "Fetch"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isIndex0 ?Colors.transparent : Colors.white70,
                        offset: Offset(0, 1),
                        blurRadius: 50,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Tab(
                      icon: SimpleAnimatedIcon(
                        startIcon: Icons.hourglass_empty,
                        endIcon: Icons.check_circle_outline,
                        progress: _progress,
                        transitions: [Transitions.zoom_in, Transitions.rotate_ccw],
                      ),
                      text: "Allow",
                    ),
                  ),
                ),
              ],
              labelColor: Color.fromARGB(255, 255, 255, 255),
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                color: Color.fromARGB(255, 29, 230, 36),
                height: 5,
                topLeftRadius: 0,
                topRightRadius: 0,
                bottomLeftRadius: 6,
                bottomRightRadius: 6,
                tabPosition: TabPosition.bottom,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
