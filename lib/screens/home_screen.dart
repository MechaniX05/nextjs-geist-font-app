import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/child_card.dart';
import '../widgets/loading_animation.dart';
import '../models/child.dart';
import 'child_details_screen.dart';
import '../utils/page_transitions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String? _error;
  List<Child> _children = [];

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    try {
      final List<Child> children = [
        Child(
          id: '1',
          name: 'Emma Thompson',
          age: 4,
          className: 'Pre-K',
          attendance: Attendance.present,
          imageUrl: 'https://images.pexels.com/photos/3771662/pexels-photo-3771662.jpeg',
          activities: ['Morning Circle', 'Art & Craft', 'Story Time'],
        ),
        Child(
          id: '2',
          name: 'Lucas Wilson',
          age: 5,
          className: 'Kindergarten',
          attendance: Attendance.absent,
          imageUrl: 'https://images.pexels.com/photos/3662667/pexels-photo-3662667.jpeg',
          activities: ['Math Games', 'Outdoor Play', 'Music'],
        ),
        Child(
          id: '3',
          name: 'Sophia Davis',
          age: 4,
          className: 'Pre-K',
          attendance: Attendance.present,
          imageUrl: 'https://images.pexels.com/photos/3662833/pexels-photo-3662833.jpeg',
          activities: ['Reading Time', 'Snack Break', 'Nap Time'],
        ),
      ];

      if (mounted) {
        setState(() {
          _children = children;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load children data. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const ShimmerLoading(
          height: 240,
          borderRadius: 15,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.child_care,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'No children added yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add a child',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildChildrenGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _children.length,
      itemBuilder: (context, index) {
        return ChildCard(
          child: _children[index],
          onTap: () {
            Navigator.push(
              context,
              SlidePageRoute(
                page: ChildDetailsScreen(child: _children[index]),
                direction: SlideDirection.right,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kindergarten Monitor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadChildren,
        child: _isLoading
            ? _buildLoadingGrid()
            : _error != null
                ? ErrorDisplay(
                    message: _error!,
                    onRetry: _loadChildren,
                  )
                : _children.isEmpty
                    ? _buildEmptyState()
                    : _buildChildrenGrid(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new child - Coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
