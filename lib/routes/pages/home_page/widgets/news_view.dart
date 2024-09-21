import 'package:flutter/material.dart';
import 'package:live_beer/text_data.dart';
import 'package:live_beer/ui/widgets/loading_indicator.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TextData.beInTouch,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => {},
                  icon: Icon(
                    Icons.arrow_forward,
                    color: theme.colorScheme.onPrimary,
                  )),
            )
          ],
        ),
        const SizedBox(height: 16),
        const NewsHorizontalView()
      ],
    );
  }
}

class NewsHorizontalView extends StatelessWidget {
  const NewsHorizontalView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 132,
      child: FutureBuilder<List<Widget>>(
        future: _getNews(theme),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const NewsTile(body: LoadingIndicator());
                },
                separatorBuilder: (context, _) {
                  return const SizedBox(width: 8);
                },
                itemCount: 3);
          } else {
            final news = snapshot.data!;
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return news[index];
                },
                separatorBuilder: (context, _) {
                  return const SizedBox(width: 8);
                },
                itemCount: news.length);
          }
        },
      ),
    );
  }

  Future<List<Widget>> _getNews(ThemeData theme) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      NewsTile(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextData.newsTitle1,
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Text(
              TextData.newsDate1,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        iconData: Icons.mic,
      ),
      NewsTile(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextData.newsTitle2,
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Text(
              TextData.newsDate1,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        iconData: Icons.percent,
      ),
      NewsTile(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextData.newsTitle2,
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Text(
              TextData.newsDate1,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        iconData: Icons.mic,
      ),
    ];
  }
}

class NewsTile extends StatelessWidget {
  final Widget body;
  final IconData? iconData;

  const NewsTile({
    super.key,
    required this.body,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          Container(
            width: 132,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: theme.colorScheme.primary),
            child: Center(child: body),
          ),
          Positioned(
              bottom: -15,
              right: -10,
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 4, color: theme.colorScheme.surface),
                    shape: BoxShape.circle,
                    color: theme.colorScheme.onPrimary),
              )),
          Positioned(
              bottom: 2,
              right: 6,
              child: Icon(iconData, color: theme.colorScheme.primary))
        ],
      ),
    );
  }
}
