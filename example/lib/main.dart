import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'transformers/accordion_transformer.dart';
import 'transformers/scale_and_fade_transformer.dart';
import 'transformers/depth_page_transformer.dart';
import 'transformers/zoom_out_page_transformer.dart';
import 'transformers/three_d_transformer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transformer PageView Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TransformerListPage(),
    );
  }
}

class TransformerListPage extends StatelessWidget {
  const TransformerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformer PageView Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          TransformerTile(
            title: 'Accordion Transformer',
            description: 'Scales pages from top-right and bottom-left',
            builder: () => TransformerDemo(
              title: 'Accordion Transformer',
              transformer: AccordionTransformer(),
            ),
          ),
          TransformerTile(
            title: 'Scale and Fade Transformer',
            description: 'Scales and fades pages as they move',
            builder: () => TransformerDemo(
              title: 'Scale and Fade Transformer',
              transformer: ScaleAndFadeTransformer(),
            ),
          ),
          TransformerTile(
            title: 'Depth Page Transformer',
            description: 'Creates a depth effect with overlapping pages',
            builder: () => TransformerDemo(
              title: 'Depth Page Transformer',
              transformer: DepthPageTransformer(),
            ),
          ),
          TransformerTile(
            title: 'Zoom Out Transformer',
            description: 'Zooms out pages during transitions',
            builder: () => TransformerDemo(
              title: 'Zoom Out Transformer',
              transformer: ZoomOutPageTransformer(),
            ),
          ),
          TransformerTile(
            title: '3D Transformer',
            description: 'Rotates pages in 3D space',
            builder: () => TransformerDemo(
              title: '3D Transformer',
              transformer: ThreeDTransformer(),
            ),
          ),
          TransformerTile(
            title: 'Loop Mode Example',
            description: 'Infinite scrolling with accordion effect',
            builder: () => const LoopModeDemo(),
          ),
          TransformerTile(
            title: 'Viewport Fraction Example',
            description: 'Shows multiple pages with custom viewport',
            builder: () => const ViewportFractionDemo(),
          ),
          TransformerTile(
            title: 'Dynamic Update Example',
            description: 'Updates itemCount and viewportFraction dynamically',
            builder: () => const DynamicUpdateDemo(),
          ),
        ],
      ),
    );
  }

}

class TransformerTile extends StatelessWidget {
  final String title;
  final String description;
  final Widget Function() builder;

  const TransformerTile({
    super.key,
    required this.title,
    required this.description,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => builder()),
          );
        },
      ),
    );
  }
}

class TransformerDemo extends StatelessWidget {
  final String title;
  final PageTransformer transformer;

  const TransformerDemo({
    super.key,
    required this.title,
    required this.transformer,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red.shade400,
      Colors.blue.shade400,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
      Colors.teal.shade400,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TransformerPageView(
        transformer: transformer,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            color: colors[index],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Page ${index + 1}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Swipe to see the transformation',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoopModeDemo extends StatelessWidget {
  const LoopModeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.pink.shade400,
      Colors.indigo.shade400,
      Colors.amber.shade400,
      Colors.cyan.shade400,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loop Mode'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TransformerPageView(
        loop: true,
        transformer: AccordionTransformer(),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            color: colors[index],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.loop,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Page ${index + 1}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Infinite scrolling enabled',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ViewportFractionDemo extends StatelessWidget {
  const ViewportFractionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.deepOrange.shade400,
      Colors.deepPurple.shade400,
      Colors.lightGreen.shade400,
      Colors.lightBlue.shade400,
      Colors.yellow.shade700,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Viewport Fraction'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TransformerPageView(
        viewportFraction: 0.8,
        transformer: ScaleAndFadeTransformer(),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Page ${index + 1}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Viewport Fraction: 0.8',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DynamicUpdateDemo extends StatefulWidget {
  const DynamicUpdateDemo({super.key});

  @override
  State<DynamicUpdateDemo> createState() => _DynamicUpdateDemoState();
}

class _DynamicUpdateDemoState extends State<DynamicUpdateDemo> {
  late TransformerPageController _controller;
  int _itemCount = 3;
  double _viewportFraction = 1.0;

  final colors = [
    Colors.red.shade400,
    Colors.blue.shade400,
    Colors.green.shade400,
    Colors.orange.shade400,
    Colors.purple.shade400,
    Colors.teal.shade400,
    Colors.pink.shade400,
    Colors.indigo.shade400,
  ];

  @override
  void initState() {
    super.initState();
    _controller = TransformerPageController(
      itemCount: _itemCount,
      viewportFraction: _viewportFraction,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateItemCount(int delta) {
    setState(() {
      final newCount = (_itemCount + delta).clamp(1, colors.length);
      _itemCount = newCount;
      _controller.setItemCount(newCount);
    });
  }

  void _updateViewportFraction(double delta) {
    setState(() {
      final newFraction = (_viewportFraction + delta).clamp(0.5, 1.0);
      _viewportFraction = newFraction;
      _controller.setViewportFraction(newFraction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Updates'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: TransformerPageView(
              pageController: _controller,
              transformer: ScaleAndFadeTransformer(),
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item Count: $_itemCount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _updateItemCount(-1),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        IconButton(
                          onPressed: () => _updateItemCount(1),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Viewport Fraction: ${_viewportFraction.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _updateViewportFraction(-0.1),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        IconButton(
                          onPressed: () => _updateViewportFraction(0.1),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
