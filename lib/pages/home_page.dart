import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hero_section.dart';
import '../widgets/categories_grid.dart';
import '../widgets/top_nav_button.dart';
import '../models/wallpaper_model.dart';
import '../pages/preview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedRoute = '/';

  final List<WallpaperModel> wallpapers = [
    WallpaperModel(
      id: '1',
      name: 'Sunset Bliss',
      category: 'Nature',
      image: 'assets/images/nature1.jpg',
      tags: ['Nature', 'Sunset', 'Warm'],
      description: 'A beautiful sunset over the serene forest landscape.',
    ),
    WallpaperModel(
      id: '2',
      name: 'Urban Lights',
      category: 'City',
      image: 'assets/images/city1.jpg',
      tags: ['City', 'Nightlife', 'Lights'],
      description: 'City skyline illuminated by dazzling lights at night.',
    ),
    WallpaperModel(
      id: '3',
      name: 'Forest Path',
      category: 'Nature',
      image: 'assets/images/nature2.jpg',
      tags: ['Nature', 'Forest', 'Pathway'],
      description: 'A tranquil path through a dense green forest.',
    ),
  ];

  void _onNavTap(String route) {
    if (_selectedRoute == route) return;
    setState(() => _selectedRoute = route);
    Navigator.pushNamed(context, route);
  }

  void _openWallpaper(WallpaperModel wallpaper) async {
    final updatedWallpaper = await Navigator.push<WallpaperModel>(
      context,
      MaterialPageRoute(
        builder: (_) => WallpaperPreviewPage(wallpaper: wallpaper),
      ),
    );

    if (updatedWallpaper != null) {
      setState(() {
        final index = wallpapers.indexWhere((w) => w.id == updatedWallpaper.id);
        if (index != -1) {
          wallpapers[index] = updatedWallpaper;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final isWide = maxWidth > 900;

            return Column(
              children: [
                // 🔝 Top Navigation
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  child: Row(
                    children: [
                      // Logo
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFA726), Color(0xFFE91E63)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Wallpaper Studio',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Navigation Buttons
                      Row(
                        children: [
                          TopNavButton(
                            icon: Icons.home_outlined,
                            label: 'Home',
                            selected: _selectedRoute == '/',
                            onTap: () => _onNavTap('/'),
                          ),
                          const SizedBox(width: 12),
                          TopNavButton(
                            icon: Icons.grid_view,
                            label: 'Browse',
                            selected: _selectedRoute == '/browse',
                            onTap: () => _onNavTap('/browse'),
                          ),
                          const SizedBox(width: 12),
                          TopNavButton(
                            icon: Icons.favorite_border,
                            label: 'Favourites',
                            selected: _selectedRoute == '/favourites',
                            onTap: () => _onNavTap('/favourites'),
                          ),
                          const SizedBox(width: 12),
                          TopNavButton(
                            icon: Icons.settings_outlined,
                            label: 'Settings',
                            selected: _selectedRoute == '/settings',
                            onTap: () => _onNavTap('/settings'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                    height: 1, thickness: 1, color: Color(0xFFECECEC)),

                // 📄 Page Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 28),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeroSection(isWide: isWide),
                          const SizedBox(height: 30),

                          // Categories Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/browse'),
                                child: const Text('See All'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          CategoriesGrid(
                            wallpapers: wallpapers,
                            isGridView: true,
                            maxWidth: maxWidth,
                            onTap: _openWallpaper,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
