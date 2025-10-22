import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String activeSection;
  final Function(String) onSectionChanged;

  const BottomNavBar({
    super.key,
    required this.activeSection,
    required this.onSectionChanged,
  });

  Widget _buildNavItem(context, IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {
        onSectionChanged(label);
        switch (label) {
          case 'Home':
            Navigator.pushNamed(context, '/home');
            break;
          case 'My Car':
            Navigator.pushNamed(context, '/mycar');
            break;
          case 'Maps':
            Navigator.pushNamed(context, '/maps');
            break;
          case 'Analytics':
            Navigator.pushNamed(context, '/analytics');
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive ? const Color(0xFFEEF2FF) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? const Color(0xFF3949AB) : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? const Color(0xFF3949AB) : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, 'Home', activeSection == 'Home'),
          _buildNavItem(context, Icons.car_rental, 'My Car', activeSection == 'My Car'),
          _buildNavItem(context, Icons.map, 'Maps', activeSection == 'Maps'),
          _buildNavItem(context, Icons.analytics, 'Analytics', activeSection == 'Analytics'),
        ],
      ),
    );
  }
}