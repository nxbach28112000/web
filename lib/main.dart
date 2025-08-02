import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: ListPage(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: "/",
    );
  }
}

const String listItemTitleText = "A BETTER BLOG FOR WRITING";
const String listItemPreviewText =
    "Sed elementum tempus egestas sed sed risus. Mauris in aliquam sem fringilla ut morbi tincidunt. Placerat vestibulum lectus mauris ultrices eros. Et leo duis ut diam. Auctor neque vitae tempus […]";

class ListPage extends StatelessWidget {
  static const String name = 'list';

  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = const Divider(
      height: 32, // khoảng cách giữa các items (tính luôn line)
      thickness: 1, // độ dày đường kẻ
      color: Colors.grey,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          ...[
            // const MinimalMenuBar(),
            const ListItem(imageUrl: "assets/images/paper_flower_overhead_bw_w1080.jpg", title: listItemTitleText, description: listItemPreviewText),
            divider,
            const ListItem(
              imageUrl: "assets/images/iphone_cactus_tea_overhead_bw_w1080.jpg",
              title: listItemTitleText,
              description: listItemPreviewText,
            ),
            divider,
            const ListItem(imageUrl: "assets/images/typewriter_overhead_bw_w1080.jpg", title: listItemTitleText, description: listItemPreviewText),
            divider,
            const ListItem(
              imageUrl: "assets/images/coffee_paperclips_pencil_angled_bw_w1080.jpg",
              title: listItemTitleText,
              description: listItemPreviewText,
            ),
            divider,
            const ListItem(
              imageUrl: "assets/images/joy_note_coffee_eyeglasses_overhead_bw_w1080.jpg",
              title: listItemTitleText,
              description: listItemPreviewText,
            ),
            divider,
          ].toMaxWidthSliver(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: MaxWidthBox(maxWidth: 1200, backgroundColor: Colors.white, child: Container()),
          ),
        ],
      ),
    );
  }
}

extension MaxWidthExtension on List<Widget> {
  List<Widget> toMaxWidth() {
    return map(
      (item) => MaxWidthBox(maxWidth: 1200, padding: const EdgeInsets.symmetric(horizontal: 32), backgroundColor: Colors.white, child: item),
    ).toList();
  }

  List<Widget> toMaxWidthSliver() {
    return map(
      (item) => SliverToBoxAdapter(
        child: MaxWidthBox(maxWidth: 1200, padding: const EdgeInsets.symmetric(horizontal: 32), backgroundColor: Colors.white, child: item),
      ),
    ).toList();
  }
}

class ListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ListItem({super.key, required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image from URL
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(width: 160, height: 120, child: Center(child: CircularProgressIndicator()));
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(width: 160, height: 120, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 40));
              },
            ),
          ),
          const SizedBox(width: 24),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
