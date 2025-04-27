import 'package:campuscravings/src/src.dart';

class AnimatedDeliveryDetailsWrapper extends ConsumerStatefulWidget {
  const AnimatedDeliveryDetailsWrapper({super.key, required this.step});
  final int step;

  @override
  ConsumerState createState() => _AnimatedDeliveryDetailsWrapperState();
}

class _AnimatedDeliveryDetailsWrapperState
    extends ConsumerState<AnimatedDeliveryDetailsWrapper> {
  final double _minHeight = 340;
  late double _height;
  late double _maxHeight;
  bool _dragging = false;
  final int _animationDuration = 200;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _height = _minHeight;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _maxHeight = MediaQuery.of(context).size.height - 100;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_height == _minHeight && _scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
    double opacity = ((_height - _minHeight) / (_maxHeight - _minHeight)) * 0.7;
    opacity = opacity < 0 ? 0 : (opacity > 0.7 ? 0.7 : opacity);
    return Material(
      type: MaterialType.transparency,
      child:
          widget.step != 0
              ? Stack(
                children: [
                  if (_height != _minHeight)
                    AnimatedContainer(
                      constraints: const BoxConstraints.expand(),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      duration: Duration(
                        milliseconds: _dragging ? 0 : _animationDuration,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      height: _height,
                      curve: Curves.easeOut,
                      duration: Duration(
                        milliseconds: _dragging ? 0 : _animationDuration,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: (details) {
                              // final tempHeight = _height - details.primaryDelta!;
                              if (((_height > _minHeight ||
                                      details.primaryDelta! < 0)) &&
                                  (_maxHeight > _height ||
                                      details.primaryDelta! > 0)) {
                                setState(() {
                                  _dragging = true;
                                  _height = _height - details.primaryDelta!;
                                });
                              }
                            },
                            onVerticalDragEnd: (details) {
                              setState(() {
                                _dragging = false;
                                if (_height < _maxHeight / 1.8) {
                                  _height = _minHeight;
                                } else {
                                  _height = _maxHeight;
                                }
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 40),
                                Container(
                                  // color: Colors.red,
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Container(
                                    height: 4,
                                    width: 50,
                                    margin: const EdgeInsets.only(
                                      top: 9,
                                      bottom: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                  ),
                                ),
                                if (_height != _maxHeight)
                                  const SizedBox(width: 40)
                                else
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _height = _minHeight;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      width: 40,
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: DeliveryDetailsWidget(
                              step: widget.step,
                              scrollController: _scrollController,
                              isMinHeight: _height == _minHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      height: _height,
                      curve: Curves.easeOut,
                      duration: Duration(
                        milliseconds: _dragging ? 0 : _animationDuration,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Expanded(
                        child: DeliveryDetailsWidget(
                          step: widget.step,
                          scrollController: _scrollController,
                          isMinHeight: _height == _minHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
