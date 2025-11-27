import 'package:amiibo_app/models/amiibo.dart';
import 'package:amiibo_app/screens/detail_screen.dart';
import 'package:amiibo_app/services/api_service.dart';
import 'package:amiibo_app/services/favorite_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final FavoriteService favService;
  const HomeScreen({super.key, required this.favService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amiibo List')),
      body: FutureBuilder<List<Amiibo>>(
        future: api.fetchAll(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final amiibo = data[index];
              return ListTile(
                leading: Image.network(amiibo.image, width: 50, height: 50),
                title: Text(amiibo.name),
                subtitle: Text(amiibo.gameSeries),
                trailing: FutureBuilder<bool>(
                  future: widget.favService.isFavorite(amiibo),
                  builder: (context, favsnap) {
                    final isFav = favsnap.data ?? false;
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : null,
                      ),
                      onPressed: () async {
                        if (isFav) {
                          await widget.favService.removeFavorite(amiibo);
                        } else {
                          await widget.favService.addFavorite(amiibo);
                        }
                        setState(() {});
                      },
                    );
                  },
                ),

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScreen(amiibo: amiibo, favService: widget.favService),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
