import 'package:amiibo_app/models/amiibo.dart';
import 'package:amiibo_app/services/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final FavoriteService favService;
  const FavoriteScreen({super.key, required this.favService});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Amiibos')),
      body: FutureBuilder<List<Amiibo>>(
        future: widget.favService.loadFavorites(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final favs = snap.data!;
          if (favs.isEmpty) {
            return const Center(child: Text('No favorite Amiibos yet.'));
          }
          return ListView.builder(
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final amiibo = favs[index];
              return ListTile(
                leading: Image.network(amiibo.image, width: 50, height: 50),
                title: Text(amiibo.name),
                subtitle: Text(amiibo.gameSeries),
              );
            },
          );
        },
      ),
    );
  }
}
