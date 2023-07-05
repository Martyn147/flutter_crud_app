import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> musicList = [];
  int loadedItemCount = 18;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadMusic();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadMusic() async {
    setState(() {
      isLoading = true;
    });

    final musicData = await getMusic();
    // Delay the setState for at least 2 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        musicList = musicData;
        isLoading = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !isLoading) {
      setState(() {
        loadedItemCount += 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: loadedItemCount,
        itemBuilder: (context, index) {
          if (index < musicList.length) {
            final musicData = musicList[index];
            return Dismissible(
              key: Key(musicData['uid']),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                await deleteMusic(musicData['uid']);
                setState(() {
                  musicList.removeAt(index);
                });
              },
              confirmDismiss: (direction) async {
                bool confirmDelete = false;
                confirmDelete = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          '¿Estás seguro de querer eliminar ${musicData['name']}?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Si, Estoy Seguro'),
                        ),
                      ],
                    );
                  },
                );
                return confirmDelete;
              },
              background: Container(
                color: const Color.fromARGB(255, 224, 58, 46),
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              child: ListTile(
                title: Text(musicData['name']),
                onTap: () async {
                  await Navigator.pushNamed(context, '/edit', arguments: {
                    "name": musicData['name'],
                    "uid": musicData['uid'],
                  });
                  setState(() {});
                },
              ),
            );
          } else if (index == loadedItemCount) {
            if (musicList.isEmpty) {
              return const Center(
                child: Text('No se encontraron datos'),
              );
            } else {
              return SizedBox(
                child: AnimatedOpacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  duration: const Duration(seconds: 3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/create');
          setState(() {});
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
