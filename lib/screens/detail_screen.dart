import 'package:amiibo_app/services/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:amiibo_app/models/amiibo.dart';

class DetailScreen extends StatelessWidget {
  final Amiibo amiibo;
  final FavoriteService favService;
  const DetailScreen({
    super.key,
    required this.amiibo,
    required this.favService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(amiibo.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(amiibo.image, width: 150, height: 150),
            ),
            const SizedBox(height: 16),
            Text('Character: ${amiibo.character}', style: const TextStyle(fontSize: 18)),
            Text('Game Series: ${amiibo.gameSeries}', style: const TextStyle(fontSize: 18)),
            Text('Amiibo Series: ${amiibo.amiiboSeries}', style: const TextStyle(fontSize: 18)),
            Text('Type: ${amiibo.type}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            Center(
              child: FutureBuilder<bool>(
                future: favService.isFavorite(amiibo),
                builder: (context, snap) {
                  final isFav = snap.data ?? false;
                  return ElevatedButton.icon(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    label: Text(isFav ? 'Remove from Favorites' : 'Add to Favorites'),
                    onPressed: () async {
                      if (isFav) {
                        await favService.removeFavorite(amiibo);
                      } else {
                        await favService.addFavorite(amiibo);
                      }
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
